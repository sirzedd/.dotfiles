
import groovy.json.JsonBuilder
import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.*
import java.nio.file.attribute.BasicFileAttributes
import java.nio.file.attribute.FileTime;

class AtomProject {

    private String app = "code";

    //Called from atom-project
    def setApp(String app) {
        this.app = app
    }
 
    def getProjects() {
        def homeDirectory = System.getProperty('user.home')
        def projectJson = "$homeDirectory/files/dev/vscode/workspaces"
        def projects = []
        def file = new File(projectJson)
        file.eachFileRecurse() { subFile ->
            def name = subFile.getName()
            if(name.contains(".code-workspace")) {
                def projectName = name.replace(".code-workspace","")
                projects.add(projectName)
            }
        }
        return projects
    }
    def getProjectFolder() {
      def homeDirectory = System.getProperty('user.home')
      def projectJson = "$homeDirectory/files/dev/vscode/workspaces"
      return projectJson
    }
    def getProjectPath(def name) {
        if(name != null) {
            def folder = getProjectFolder()
            def projectFile = folder + "/$name" + ".code-workspace"
            projectFile
        }
        else {
            println "name null in getProjectPath"
            return ""
        }
    }

    def openProject(def name, def projects) {
        if(name == null) {
            listStories(projects);
            return
        }
        def projectContained = contains(name, projects)
        if(projectContained == null) {
            println "Project '$name' does not exist"
            return
        }
        println "opening $projectContained"
        def path = getProjectPath(projectContained)
        def command = "$app $path"
        println command
        command.execute()
    }

    def contains(def name, def projects) {
        for(def project: projects) {
            if(project.contains(name)) {
                return project
            }
        }
        return null
    }

    def getProjectFile(def name) {
        def projectPath = getProjectPath(name)
        def file = new File(projectPath)
        file
    }

    def saveProjectFile(def name, def result) {
        def file = getProjectFile(name)
        def newProjectString = new JsonBuilder(result).toPrettyString()
        file.text = newProjectString
        println "Complete"
    }

    def getProject(def projectName) {
        def slurper = new groovy.json.JsonSlurper()
        projectName = projectName.trim().toLowerCase()
        def file = getProjectFile(projectName)
        def json = file.text
        def result = slurper.parseText(json);
        return result
    }
    def deleteProject(def name, def projects) {
        if(!projects.contains(name)) {
            println "Project '$name' does not exist"
            return
        }
        def file = getProjectFile(name)
        boolean deleted = file.delete()
        if(deleted) {
            println "project '$name' deleted"
        }
        else {
            println "project '$name' was not deleted"
        }
    }

    def addPath(def projects, def arguments) {
        if(arguments[0] == null) {
            println "Need story number"
            listStories(projects)
            return
        }
        String projectName = arguments[0].trim()
        def project = getProject(projectName)
        if (project == null) {
            println "Project $projectName does not exist"
            return
        }

        def dir = System.getProperty('user.dir')
        boolean contained = project.folders.contains(dir)
        if (contained) {
            println "Path already exists"
            return
        }

        project.folders << dirToWorkspace(dir)

        saveProjectFile(projectName, project)

    }
    /* def dirToWorkspace(def dir){
        "file://$dir"
    } */
    def dirToWorkspace(def dir){
        def json = new JsonBuilder()
        json path:dir 
    }

    def editProject(def result, def projects, def arguments) {
        //TODO nothing really to edit now
//        saveProjectFile(result)
    }

    def newProject(def projects, def arguments) {
        def name = arguments[0]
        if(name == null || name == "null") {
            println "Need a name for the project"
            return
        }
        if(projects.contains(name)) {
            println "There already exists project with this name '$name'"
            return
        }
        def json = new JsonBuilder()
        def dir = System.getProperty('user.dir')

        def result = json id:"1", folders:[dirToWorkspace(dir)]

        saveProjectFile(name, result)

    }
    def listStories(projects) {
        projects.each { println it}
    }

    def openAtomProjectJson() {
      def openInAtom = "atom " + getProjectPath()
      println "opening"
      openInAtom.execute()
    }
    def changedFiles = [:]

    final Map<WatchKey, Path> keys = new HashMap<>();

    def watch(def path, def include, def exclude, def showOutput, def command) {
//        def dirPath = System.getProperty('user.dir')
      Path directory = Paths.get(path)
      WatchService watchService = FileSystems.getDefault().newWatchService()
        def recursive = true
       if(recursive) {
           // register directory and sub-directories
           Files.walkFileTree(directory, new SimpleFileVisitor<Path>() {
               @Override
               public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs)
                       throws IOException
               {
                   WatchKey watchKey = dir.register(watchService, StandardWatchEventKinds.ENTRY_MODIFY);
                   keys.put(watchKey, dir);
                   //keep track of all the key/directories to lookup file.
                   return FileVisitResult.CONTINUE;
               }
           })
       }
      else {
           directory.register(watchService, StandardWatchEventKinds.ENTRY_MODIFY);
       }
//      def cooldown = 5000  //TODO the file is notified twice when changing.  The idea of the cooldown was to stop the second.
//        def startTime = 0
//        def endTime = 0
        boolean executing = false

      while (true) {
          WatchKey key = watchService.take()
          Path grabbedDir = keys.get(key)
          for ( WatchEvent<?> event: key.pollEvents()){
              //we only register "ENTRY_MODIFY" so the context is always a Path.
              final Path changed = (Path) event.context()
              Path child = grabbedDir.resolve(changed)
              boolean changedFile = notifyChange(child, include, exclude)
              debug "Changed $changed $changedFile"
              if (changedFile) {
                if(command != null && command.size() > 0) {
                  info("My file has changed '$changed' running $command")
                    Thread.start {
                        Process proc = command.execute()
                        proc.waitFor()
                        if(showOutput) {
                            def output= proc .in.text;
                            info "command executed $output"
                        }
                        else {
                            info "command executed"
                        }
                        boolean valid = key.reset()
                    }
                }
                else {
                  info("My file has changed '$changed'")
                }
              }
          }
          //reset is invoked to put the key back to ready state
          boolean valid = key.reset()
          //If the key is invalid, just exit.
          if ( !valid ) {
              break
          }
      }
    }
    def debug(def output) {
    //  println output
    }

    def info(def output) {
        println output
    }

    def isDirectory(String value) {
            def dir = System.getProperty('user.dir')
            if(!value.startsWith("/")) {
                value = "/" + value
            }
            def fullDir = dir+value
            def includeFile = new File(fullDir);
            debug "checking dir " + fullDir

            boolean fileExists =      includeFile.exists();      // Check if the file exists
            boolean isDirectory = includeFile.isDirectory(); // Check if it's a directory
            debug "file exists $fileExists and is directory $isDirectory"
            return fileExists || isDirectory
    }

    def matchedDirectory(Path changed, String value, String secondarySearch) {
        def dir = System.getProperty('user.dir')
        if(!value.startsWith("/")) {
                value = "/" + value
            }
        def fullDir = dir+value
        //is a file or directory
        def file = changed.toFile();
        debug "path " + file.getCanonicalPath() + " contains " + fullDir
        boolean pathsContain = file.getCanonicalPath().contains(fullDir);
        if(pathsContain) {
            debug "contained"
            if(secondarySearch.length() > 0) {
                containsType(changed, secondarySearch)
            }
            else {
                return true
            }
        }
    }

    def containsType(Path changed, String include) {
        def changedName = changed.toString()
        //not a directory or file
        if(include.equals("*") || changedName.endsWith(include)) {
            try {
                def file = changed.toFile();
                long fileLastModified = file.lastModified()
                def savedLastModified = changedFiles.get(changed)
                if (savedLastModified != null && fileLastModified == savedLastModified) {
                    //if same modification time don't execute.  This change has already happened and has been stored
                    debug "saved was same false"
                    return false
                }
                //different modified times, saving
                changedFiles.put(changed, fileLastModified)
                debug "saved was not same true"
                return true
            }
            catch(Exception e) {
                debug "Exception " + e.getMessage()
            }
            debug "made it here, what does this mean"
            return true;
        }
    }

    boolean notifyChange(Path changed, def includes, def excludes) {
        def changedName = changed.toString()
        changedName = changedName.trim().toLowerCase();
        debug "starting excludes"
        for (String exclude : excludes)
        {
            exclude = exclude.trim().toLowerCase();
            if (exclude.length() > 0 && changedName.endsWith(exclude))
            {
              debug "exluding"
                return false;
            }
        }
        debug "starting includes"
        for(String include : includes) {
            include = include.trim();
            debug include
            if(include.contains("*")){
                debug "contained, now splitting"
                def splitInclude = include.split("\\*")
                if(splitInclude.size() == 2) {
                    def possibleFolder = splitInclude[0]
                    def possibleType = splitInclude[1]
                    Boolean isFolder = isDirectory(possibleFolder)
                    if(isFolder) {
                        debug "include $include type $possibleType"
                        return matchedDirectory(changed, possibleFolder, possibleType)
                    }
                }
            }

            def isFolder = isDirectory(include)
            if(isFolder) {
                //is a file or directory
                return matchedDirectory(changed, include, "")
            }
            else {
                include = include.trim().toLowerCase();
                containsType(changed, include)
            }
        }
        debug "last false"
        return false;
    }


    def grabArgs(List<String> args, def list) {
        
        for(int y = 0; y <= args.size(); y++) {
            if(args.size() == 0) {
                break;
            }
            def ar = args.get(0)
            if(
                ar.size() == 2 && (
                    ar.contains("-i") || 
                    ar.contains("-e") || 
                    ar.contains("-c") ||
                    ar.contains("-s")
                )
                ) {
                break
            }
            else {
                args.remove(0)
                debug "adding $ar"
                list.add(ar)
            }
        }
    }

    def separateArgs(List<String> args) {
        def path = args.get(0)
        def include = []
        def command = []
        def showOutput = false;
        def exclude = []

        while(args.size() != 0) {
            def arg = args.remove(0)
            if(arg == "-i") {  //Include watch on files
                grabArgs(args, include)
            }
            else if(arg == "-e") {
                grabArgs(args, exclude)
            }
            else if(arg == "-c") {
                grabArgs(args, command)
            }
            else if(arg == "-s") {
                showOutput = true
            }
        }
        if(include.size() == 0) { //if no include, include all
            include = ["*"]
        }
        def commandString = command.join(" ")
        return [path, include, exclude, showOutput, commandString]
    }
  }
