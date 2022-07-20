extern crate skim;
use std::{vec, env};
use std::fs::File;
use std::io::BufRead;
use regex::Regex;
use std::io;
use clipboard::ClipboardProvider;
use clipboard::ClipboardContext;



fn get_file_contents(dir: &String) -> String {
     let mut data = String::new();
     let f = File::open(dir).expect("Unable to open file");
     let br = io::BufReader::new(f);

     for (index, line) in br.lines().enumerate() {
        let line = line.unwrap();
        data = format!("{}\n{}", data.to_owned(), line.to_owned());
     }

     data
}

pub fn main() {
    let name = "SNIPPET_FILE_FOUND";
    let directory =  match env::var(name) {
        Ok(v) => v,
        Err(e) => panic!("${} is not set ({})", name, e)
    };


    println!("Found stuff {}", directory);
    let file_content = get_file_contents(&directory);

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
    copy_to_clipboard(new_content);
   }

fn copy_to_clipboard(content: String) {
    let mut ctx: ClipboardContext = ClipboardProvider::new().unwrap();
    ctx.set_contents(content).unwrap();
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
