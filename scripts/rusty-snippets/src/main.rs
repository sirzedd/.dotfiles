extern crate skim;
use std::fmt::format;
use std::{vec, fs, env};
use std::fs::File;
use std::io::BufRead;
use regex::Regex;
use std::io;
use std::path::Path;
use skim::prelude::*;

use clipboard::ClipboardProvider;
use clipboard::ClipboardContext;

#[derive(Debug, Clone)]
struct Item {
    text: String,
    preview: String,
}

impl SkimItem for Item {
    fn text(&self) -> Cow<str> {
        Cow::Borrowed(&self.text)
    }

    fn preview(&self, _context: PreviewContext) -> ItemPreview {
        //if !self.preview.is_empty() {
        //   return ItemPreview::Text(self.preview.to_owned()); 
        //}
        //return ItemPreview::Text(self.text.to_owned())
        return ItemPreview::Text(self.preview.to_owned());
    }
}

fn get_file_contents(dir: &String) -> String {
     let mut data = String::new();
     let f = File::open(dir).expect("Unable to open file");
     let br = io::BufReader::new(f);

     for (index, line) in br.lines().enumerate() {
        let line = line.unwrap();
        data = format!("{}\n{}", data.to_owned(), line.to_owned());
     }

     return data;
}

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

//1. Get directory
//2. build items with previews for skim
//3. Take selected item and convert snippet {{}} with inputs from user 
//4. Copy to clipboard.  
//
//Might try to replace 1,2, and 4. with terminal commands.  Build rust script for 3.
pub fn main() {
    let snippet_dir_env = "SNIPPET_DIR";
    let _home = env::var("HOME").unwrap();
    let mut snippet_dir = format!("{}{}", _home, String::from("/.dotfiles/snippets"));
    match env::var(snippet_dir_env) {
        Ok(val) => {
            println!("{snippet_dir_env}: {val:?}");
            snippet_dir = val;
        },
        Err(e) => println!("couldn't find {snippet_dir_env} : defaulting to {snippet_dir} "),
    }

    let find_path = fs::read_dir(&*snippet_dir);

    let (tx, rx): (SkimItemSender, SkimItemReceiver) = unbounded();

    match find_path {
        Ok(paths) => {
            for path in paths {
                let dir = path.unwrap().path().display().to_string();
                let file_preview = get_file_contents(&dir);
                tx.send(Arc::new(Item {text: dir, preview: file_preview } )).unwrap();
            }
        },
        Err(e) =>  println!("couldn't find directory: {e}"),
    }

    drop(tx);

    let options = SkimOptionsBuilder::default()
        .height(Some("100%"))
        .multi(true)
        .preview(Some(""))
        .build()
        .unwrap();

    let selected_items = Skim::run_with(&options, Some(rx))
        .map(|out| out.selected_items)
        .unwrap_or_else(|| Vec::new())
        .iter()
        .map(|selected_item| (**selected_item).as_any().downcast_ref::<Item>().unwrap().to_owned())
        .collect::<Vec<Item>>();

    
    for item in selected_items {
        let file_content = item.preview;
        let mut new_content = file_content.to_string();
        let inputs = find_inputs(file_content);

        for input in inputs {
            println!("Enter {}", input);
            let mut input_text = String::new();
            io::stdin()
                .read_line(&mut input_text)
                .expect("failed to read from stdin");

            let trimmed = input_text.trim();
            let replace_value = format!("{}{}{}","{{", input, "}}");
            new_content = new_content.replace(&replace_value, trimmed);
        }

        println!("{}", new_content);
        let mut ctx: ClipboardContext = ClipboardProvider::new().unwrap();
        ctx.set_contents(new_content.to_owned()).unwrap();
    }
}



fn find_inputs(content: String) -> Vec<String> {
   let re = Regex::new(r"\{\{(.*)\}\}").unwrap();
   //let re = Regex::new(r"^\{\{[a-z0-9](\.?[a-z0-9])*$").unwrap();
   let mut values = vec![];
   for cap in re.captures_iter(&content) {
    values.push(String::from(&cap[1]));
   }
   values
}
