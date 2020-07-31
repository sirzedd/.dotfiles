#!/usr/bin/env groovy

import groovy.json.JsonSlurper
import groovy.json.JsonBuilder
/**
 * Created by jhendricks on 6/22/17.
 */
/**
* TODO can i pipe diff to this script.  Push into tmp file
*/
this.getClass().classLoader.rootLoader.addURL(new File("/Users/jhendricks/Google Drive/bin").toURL())
def cli = new CliBuilder(usage: "ap -[hlvneardosfw] [commands]")

cli.with {
    h  longOpt:  'help',             "Show usage information"
    notes longOpt: 'notes',          "Current Notes"
    bm longOpt:  'bookmark',         "Edit bookmark file"
    l  longOpt:  'list',             "List project names"
    todo longOpt: 'todo',            "Open todos "
    v  longOpt:  'view',             "View project details"
    np longOpt:  'new-project',      "Create new project"
    ep longOpt:  'edit-project',     "Edit project"
    ap longOpt:  'add-path',         "Add to project path"
    rp longOpt:  'remove-path',      "Remove project path"
    dp longOpt:  'delete-path',      "Delete project"
    op longOpt:  'open',             "Open project"
    t  longOpt:  'temp',             "Re-open temp file used for pipe command"
    s  longOpt:  'script',           "Open scripts"
    f  longOpt:  'file',             "Open file"
    n  longOpt:  'new',              "Open file in new window"
    c  longOpt:  'current',          "Add project to current window"
    w  longOpt:  'watch',            
"""-i [include files or folders space separated defaults to *] -e [exclude files or folders space separated] -c [command to execute]
ap -w . -i bundle.js -c mvn compile
ap -w . -i /src/*.java -c mvn compile"""
//TODO add time watch to check for hours
}

// def app = "code-insiders"
def app = "code"
def notes_file = "/Users/jhendricks/gdrive/work/documents/notes/current_notes.md"

def todo_file = "/Users/jhendricks/gdrive/work/dev/todo/work.todo"

def options = cli.parse(args)
if(!options) {
    return
}

if(options.h) {
    cli.usage()
    return
}

def atomProject = Class.forName("AtomProject").newInstance()
atomProject.setApp(app)
def projects = atomProject.getProjects()
def arguments = options.arguments()

def currentDir = new File(".").canonicalPath
if(options.w) {
  def (path, include, exclude, showOutput, command) = atomProject.separateArgs(arguments)
  println "watching $path including '$include' excluding '$exclude' showOutput '$showOutput' command '$command'"
  atomProject.watch(path, include, exclude, showOutput, command)
}
else if(options.todo) {
     println "Opening todo"
     def command = "$app $todo_file"
     command.execute()
}
else if (options.notes) {
     println "Opening notes"
     def command = "$app $notes_file"
     command.execute()
}
else if(options.bm) {
  println "Opening bookmark folder"
  def command = "$app /Users/jhendricks/.apparixrc"
  command.execute()
}
else if(options.l) {
    println "Project Names"
    atomProject.listStories(projects)
}
else if(options.v) {
    String projectName = arguments[0]
    if(projectName == null) {
      println "Need story number"
      atomProject.listStories(projects)
      return
    }
    def project = atomProject.getProject(projectName, projects)
    def prettyProject = new JsonBuilder(project).toPrettyString()
    println(prettyProject)
}
else if(options.n) {
    //open file in new window
    def path = arguments[0]
    "$app -n $path".execute()
}
else if(options.np) {
    // Boolean addDir = false
    // if(options.a) {
    //     addDir = true
    // }
    atomProject.newProject(projects, arguments)
}
else if(options.ep) {
    //TODO edit ap -e 3345 name=TA-3346
    atomProject.editProject(result, projects, arguments)
}
else if(options.ap) {
    //TODO add project at currentDir
    atomProject.addPath(projects, arguments)
}
else if(options.t) {
  "$app /tmp/atom-project-tmp".execute()
}
else if(options.r) {
  println "removing project TODO doesn't work"
  
    //TODO remove ap -r 3345. Ask if it's okay to do before doing so.  Show path that will be deleted.  Try again option.
    //Maybe show the list and numbers next that can be deleted
}
else if(options.dp) {
  def name = arguments[0]
  println "deleting project TODO doesn't work"
  atomProject.deleteProject(name, projects)
}
else if(options.op){
    def name = arguments[0]
    atomProject.openProject(name, projects)
}
else if(options.s) {
  //Open ap scripts
  def command = "$app /Users/jhendricks/bin/bin/atom-project.groovy /Users/jhendricks/bin/bin/AtomProject.groovy"
  command.execute()
}
else if(options.f) {
  println "opening file"
  // open a file or folder.  Used for opening piped commands.
  def filePath =  arguments[0]
  "$app $filePath".execute()
}
else if(arguments.size() > 0) {
  if(arguments[0] == "..") {
    //reuse last window
    "$app -r .".execute()
  }
  else if(arguments[0] == ".") {
    "$app .".execute()
  }
  else if(new File(arguments[0]).exists()) {
    println "opening file " + arguments[0];
    def openFile = "$app -n " + arguments[0]
    openFile.execute()
  }
  else {
    println "Didn't know what to do with arguments " + arguments[0]
  }
}
else {
    println "Could not find command " + arguments[0];
    cli.usage()
    return
}
