import {Component, OnInit} from '@angular/core';
import {AbstractControl, FormControl, FormGroup, Validators} from "@angular/forms";
import * as XLSX from 'xlsx';
import {McqService} from "../mcq.service";
import {AuthService} from "../../auth/auth.service";
import {MatSnackBar} from '@angular/material/snack-bar';
import {ActivatedRoute, Router} from "@angular/router";
import {parseJson} from "@angular/cli/src/utilities/json-file";
@Component({
  selector: 'app-mcq-add',
  templateUrl: './mcq-add.component.html',
  styleUrls: ['./mcq-add.component.css']
})




export class McqAddComponent implements OnInit {

  editMode = false;
  loading: boolean = true;
  userIsProblemSetter: boolean= true;
  excelJsonData:any;
  excelDataUploadStatus: string[] = [];

  questionImagePreviewUrl: any;
  optionOneImagePreviewUrl: any;
  optionTwoImagePreviewUrl: any;
  optionThreeImagePreviewUrl: any;
  optionFourImagePreviewUrl: any;
  explanationImagePreviewUrl: any;


  questionImageFile: any;
  optionOneImageFile: any;
  optionTwoImageFile: any;
  optionThreeImageFile: any;
  optionFourImageFile: any;
  explanationImageFile: any;
  selectedSubject:any;

  subjects :any;
  category :any;
  hardness :any;
  problem_setter:any;
  id:any;
  displayedColumns = ['question','subject','chapter','categories','hardness','option_text_1','option_text_2',
  'option_text_3','option_text_4','correct_ans','explanation'];






  mcqForm = new FormGroup({
  question: new FormControl('', Validators.required),
  question_img: new FormControl(null),
  option_text_1: new FormControl(null),
  option_img_1: new FormControl(null),
  option_text_2: new FormControl(null),
  option_img_2: new FormControl(null),
  option_text_3: new FormControl(null),
  option_img_3: new FormControl(null),
  option_text_4: new FormControl(null),
  option_img_4: new FormControl(null),
  correct_ans: new FormControl(null,Validators.required),
  explanation: new FormControl('',Validators.required),
  explanation_img: new FormControl(null),
  hardness: new FormControl(null, Validators.required), // Add Validators.required
  categories: new FormControl(null,Validators.required),
  subject: new FormControl(null,Validators.required),
  chapter: new FormControl({ value: null,disabled: true }),
  problem_setter: new FormControl(),
  verified: new FormControl( false ),
  published: new FormControl( false ),
  // }, { validators: this.optionValidation });
  }, );

  constructor(
    private mcqService: McqService,
    private authService:AuthService,
    private snackBar: MatSnackBar,
    private router:Router,
    private route: ActivatedRoute

) {}


  ngOnInit() {
    this.getConText();
    this.userIsProblemSetter = this.authService.isProblemSetter()
    this.route.queryParamMap.subscribe(params => {
      if (params.has('id')) {
        this.id = params.get('id');
        this.editMode =true;
        this.editModeDataSet();
      }
    });
  }








  getConText(){
    this.mcqService.getMcqAddContext().subscribe({
      next: (response)=>{
        this.subjects = Object.values(response.data.subject);
        this.category = response.data.category;
        this.hardness = response.data.hardness;
        this.problem_setter = response.data.problem_setter;
      },
      error: (err)=>{
        console.log(err.status_code);
        console.log(err.error);

        console.log(err.error.status);
        console.log(err.error.errors);
        console.log(err.error.message);
      },
      complete:()=>{}
    });
  }

  // In your component class
  optionValidation(control: AbstractControl) {

    if (!control.get('option_text_1')?.value && !control.get('option_img_1')?.value) {
      control.get('option_text_1')?.setErrors({ required: true });
      control.get('option_img_1')?.setErrors({ required: true });
    } else {
      control.get('option_text_1')?.setErrors(null);
      control.get('option_img_1')?.setErrors(null);
    }

    if (!control.get('option_text_2')?.value && !control.get('option_img_2')?.value) {
      control.get('option_text_2')?.setErrors({ required: true });
      control.get('option_img_2')?.setErrors({ required: true });
    } else {
      control.get('option_text_2')?.setErrors(null);
      control.get('option_img_2')?.setErrors(null);
    }

    if (!control.get('option_text_3')?.value && !control.get('option_img_3')?.value) {
      control.get('option_text_3')?.setErrors({ required: true });
      control.get('option_img_3')?.setErrors({ required: true });
    } else {
      control.get('option_text_3')?.setErrors(null);
      control.get('option_img_3')?.setErrors(null);
    }


    if (!control.get('option_text_4')?.value && !control.get('option_img_4')?.value) {
      control.get('option_text_4')?.setErrors({ required: true });
      control.get('option_img_4')?.setErrors({ required: true });
    } else {
      control.get('option_text_4')?.setErrors(null);
      control.get('option_img_4')?.setErrors(null);
    }
    return null;
  }
  selectSubjectChange(event:any){
    // @ts-ignore
    this.selectedSubject = this.subjects.find(subject=> subject.name === event.value);
    this.selectedSubject = this.selectedSubject.chapters;
    if (this.selectedSubject) {
      this.mcqForm.get('chapter')?.enable();
    } else {
      this.mcqForm.get('chapter')?.disable();
    }
  }

  readExcelData(event: Event): void {

    const input = event.target as HTMLInputElement;
    const file = input.files?.[0];
    if (file) {
      const fileReader = new FileReader();
      fileReader.onload = (e: any) => {
        const data = e.target.result;
        const workbook = XLSX.read(data, { type: 'binary' });
        const firstSheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[firstSheetName];
        const jsonData = XLSX.utils.sheet_to_json(worksheet);
        this.excelJsonData =jsonData;

        for (let i = 0; i < jsonData.length; i++) {
          this.excelDataUploadStatus.push('MintCream');
        }

        console.log(jsonData);
      };
      fileReader.readAsBinaryString(file);
    }

  }


  cancelExcelFileData(){
    this.excelJsonData=null;
    this.excelDataUploadStatus =[];
    location.reload();

  }
  uploadExcelFileData(){

    for (const [index, row] of this.excelJsonData.entries()) {
      // console.log(index, row);
      let formData:FormData = new FormData()

      formData.append('question', row.question || '');
      formData.append('option_text_1', row.option_text_1 || '');
      formData.append('option_text_2', row.option_text_2 || '');
      formData.append('option_text_3', row.option_text_3 || '');
      formData.append('option_text_4', row.option_text_4 || '');
      formData.append('correct_ans', row.correct_ans || '');
      formData.append('explanation', row.explanation || '');
      formData.append('subject', row.subject || '');
      formData.append('chapter', row.chapter || '');
      formData.append('hardness', row.hardness || '');
      formData.append('categories', row.categories || '');
      // formData.append('problem_setter', problem_setter || '');

      // console.log(formData);

      // formData.forEach((value, key) => {
      //   console.log(`${key}: ${value}`);
      // });
      this.excelDataUploadStatus[index]='SpringGreen';
      this.mcqService.addNewMcq(
        formData
      ).subscribe({
        next: (response)=>{
          this.excelDataUploadStatus[index]='Turquoise';

          this.snackBar.open('MCQ added successfully', 'Dismiss', {
            duration: 3000, // Duration in milliseconds (3 seconds in this example)
            panelClass: 'success-snackbar' // Custom CSS class for styling success messages
          });
          this.clearFileUrl();
        },
        error: (err)=>{
          console.log(err)
          this.excelDataUploadStatus[index]='Salmon';


          this.snackBar.open(err.message, 'Dismiss', {
            duration: 3000, // Duration in milliseconds (3 seconds in this example)
            panelClass: 'error-snackbar' // Custom CSS class for styling error messages
          });
        },
        complete:()=>{}
      });



    }

    // this.excelJsonData.clear;
    // this.excelDataUploadStatus=[];

  }
  onImageChange(formControlName: string, event: any) {
    if (event.target.files && event.target.files.length) {
      const file = event.target.files[0];
      const reader = new FileReader();

      reader.onload = (e: any) => {
        switch (formControlName) {
          case 'question':
            this.questionImagePreviewUrl = e.target.result;
            this.questionImageFile = file;
            break;
          case 'option_1':
            this.optionOneImagePreviewUrl = e.target.result;
            this.optionOneImageFile = file;
            this.mcqForm.controls.option_text_1.setErrors(null);
            break;
          case 'option_2':
            this.optionTwoImagePreviewUrl = e.target.result;
            this.optionTwoImageFile = file;
            this.mcqForm.controls.option_text_2.setErrors(null);
            break;
          case 'option_3':
            this.optionThreeImagePreviewUrl = e.target.result;
            this.optionThreeImageFile=file;
            this.mcqForm.controls.option_text_3.setErrors(null);

            break;
          case 'option_4':
            this.optionFourImagePreviewUrl = e.target.result;
            this.optionFourImageFile = file;
            this.mcqForm.controls.option_text_4.setErrors(null);

            break;
          case 'explanation':
            this.explanationImagePreviewUrl = e.target.result;
            this.explanationImageFile = file;
            break;
          default:
            break;
        }
      };
      reader.readAsDataURL(file);
    }
  }
  cancelImage(formControlName: string,){
    switch (formControlName) {
      case 'question':
        this.questionImagePreviewUrl = null;
        this.questionImageFile =  null;
        break;
      case 'option_1':
        this.optionOneImagePreviewUrl = null;
        this.optionOneImageFile = null;
        break;
      case 'option_2':
        this.optionTwoImagePreviewUrl = null;
        this.optionTwoImageFile = null;
        break;
      case 'option_3':
        this.optionThreeImagePreviewUrl = null;
        this.optionThreeImageFile = null;
        break;
      case 'option_4':
        this.optionFourImagePreviewUrl = null;
        this.optionFourImageFile = null;
        break;
      case 'explanation':
        this.explanationImagePreviewUrl = null;
        this.explanationImageFile = null;
        break;
      default:
        break;
    }
  }


  editModeDataSet(){
    this.mcqService.getMcq(this.id).subscribe({
      next: (response)=>{
        // console.log(response);
        // console.log(this.questionImagePreviewUrl);
        // console.log(response.question_img);
        this.questionImagePreviewUrl =response.question_img;
        this.optionOneImagePreviewUrl =response.option_img_1;
        this.optionTwoImagePreviewUrl =response.option_img_2;
        this.optionThreeImagePreviewUrl =response.option_img_3;
        this.optionFourImagePreviewUrl =response.option_img_4;
        this.explanationImagePreviewUrl  =response.explanation_img;
        response.question_img= null;
        response.option_img_1= null;
        response.option_img_2= null;
        response.option_img_3= null;
        response.option_img_4= null;
        response.explanation_img= null;
        if(response.subject){
        this.mcqForm.get('chapter')?.enable();
          // @ts-ignore
          this.selectedSubject = this.subjects.find(subject=> subject.name === response.subject);
          this.selectedSubject = this.selectedSubject.chapters;
        }
        this.mcqForm.patchValue(response);
      },
      error: (err)=>{
        this.snackBar.open(err.message, 'Dismiss', {
          duration: 3000, // Duration in milliseconds (3 seconds in this example)
          panelClass: 'error-snackbar' // Custom CSS class for styling error messages
        });
      },
    })
  }



  clearFileUrl(){
    this.questionImagePreviewUrl = null;
    this.questionImageFile =  null;
    this.optionOneImagePreviewUrl = null;
    this.optionOneImageFile = null;
    this.optionTwoImagePreviewUrl = null;
    this.optionTwoImageFile = null;
    this.optionThreeImagePreviewUrl = null;
    this.optionThreeImageFile = null;
    this.optionFourImagePreviewUrl = null;
    this.optionFourImageFile = null;
    this.explanationImagePreviewUrl = null;
    this.explanationImageFile = null;
  }

  onSubmit(): void {
    if (this.mcqForm.valid) {

      let formData:FormData = new FormData()

      formData.append('question', this.mcqForm.value.question || '');
      formData.append('option_text_1', this.mcqForm.value.option_text_1 || '');
      formData.append('option_text_2', this.mcqForm.value.option_text_2 || '');
      formData.append('option_text_3', this.mcqForm.value.option_text_3 || '');
      formData.append('option_text_4', this.mcqForm.value.option_text_4 || '');
      formData.append('correct_ans', this.mcqForm.value.correct_ans || '');
      formData.append('explanation', this.mcqForm.value.explanation || '');
      formData.append('subject', this.mcqForm.value.subject || '');
      formData.append('chapter', this.mcqForm.value.chapter || '');
      formData.append('hardness', this.mcqForm.value.hardness || '');
      formData.append('categories', this.mcqForm.value.categories || '');
      formData.append('problem_setter', this.mcqForm.value.problem_setter || '');
      formData.append('verified',  this.mcqForm.value.verified!.toString());
      formData.append('published', this.mcqForm.value.published!.toString());

      if(this.editMode){
        if(this.questionImagePreviewUrl == null){
          formData.append('question_img','');
        }
        if(this.optionOneImagePreviewUrl == null){
          formData.append('option_img_1','');
        }
        if(this.optionTwoImagePreviewUrl == null){
          formData.append('option_img_2','');
        }
        if(this.optionThreeImagePreviewUrl == null){
          formData.append('option_img_3','');
        }
        if(this.optionFourImagePreviewUrl == null){
          formData.append('option_img_4','');
        }
        if(this.explanationImagePreviewUrl == null){
          formData.append('explanation_img','');
        }
      }

      if(this.questionImageFile){
      formData.append('question_img', this.questionImageFile);
      }
      if(this.optionOneImageFile){
      formData.append('option_img_1', this.optionOneImageFile);
      }
      if(this.optionTwoImageFile){
      formData.append('option_img_2', this.optionTwoImageFile);
      }
      if(this.optionThreeImageFile){
      formData.append('option_img_3', this.optionThreeImageFile);
      }
      if(this.optionFourImageFile){
      formData.append('option_img_4', this.optionFourImageFile);
      }
      if(this.explanationImageFile) {
      formData.append('explanation_img', this.explanationImageFile);
      }



      if(this.editMode){
        this.mcqService.updateMcq(formData,this.id).subscribe({
          next: (response)=>{
            this.mcqForm.reset();
            location.reload();
            this.snackBar.open('MCQ updated successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.clearFileUrl();
          },
          error: (err)=>{
            console.log(err)

            this.snackBar.open(err.message, 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'error-snackbar' // Custom CSS class for styling error messages
            });
            if(err.error){

              for (let [key, value] of Object.entries(err.error)) {
                // @ts-ignore
                this.mcqForm.controls[key].setErrors({'api_error':value});
              }

            }
          },
          complete:()=>{}
        })
      }
      else{
        this.mcqService.addNewMcq(
          formData
        ).subscribe({
          next: (response)=>{
            this.mcqForm.reset();
            location.reload();
            this.snackBar.open('MCQ added successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.clearFileUrl();
          },
          error: (err)=>{
            console.log(err)

            this.snackBar.open(err.message, 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'error-snackbar' // Custom CSS class for styling error messages
            });
            if(err.error){

              for (let [key, value] of Object.entries(err.error)) {
                // @ts-ignore
                this.mcqForm.controls[key].setErrors({'api_error':value});
              }

            }
          },
          complete:()=>{}
        });

      }

    } else {
      console.log("Please fill in all required fields.");
      // location.reload();
    }
  }


  formUpload(formData:FormData){


  }

}


