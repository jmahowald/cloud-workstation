package cmd

import (
	"text/template"
	"log"
  "os"
  "fmt"
  "io/ioutil"
  "path/filepath"
)

func ParseTemplate(name,path string) *template.Template {


	// var templateBytes byte[]
  var templateBytes []byte
  var err error
	if(EmbeddedTemplatesDir == "") {
		templateBytes, err = Asset(fmt.Sprintf("templates/%s",path))
		if err != nil {
			log.Fatalln("Unable to retrieve asset file", err)
		}
	} else {
		templateBytes, err = ioutil.ReadFile(fmt.Sprintf("%s/%s",EmbeddedTemplatesDir,path))
		if err != nil {
			log.Fatalf("Unable to load template file %s/%s:%v",EmbeddedTemplatesDir,path, err)
		}
	}
	tmpl, err := template.New(name).Parse(string(templateBytes))
	if err != nil {
		log.Fatalln("Unable to parse template", err)
	}
	return tmpl
}


func TerraformPath(moduleName string ) string {
	return filepath.Join(TfDir,EnvName,moduleName)
}

const dirMode = 0755

func OpenForWrite(modName,fileName string) *os.File {
  dirPath := TerraformPath("s3bucket")
  err := os.MkdirAll(dirPath, dirMode)
  if err != nil {
		log.Fatalf("Unable to create directory at %s:%s", dirPath, err)
	}

	file := filepath.Join(dirPath, fileName)
	f, err := os.Create(file)
  if err != nil {
		log.Fatalf("Unable to create file at %s:%v", file, err)
	}
  return f
}
