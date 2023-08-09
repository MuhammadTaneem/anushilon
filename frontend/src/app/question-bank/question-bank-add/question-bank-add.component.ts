import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {ExamService} from "../../exam/exam.service";
import {McqService} from "../../mcq/mcq.service";
import {AuthService} from "../../auth/auth.service";
import {MatSnackBar} from "@angular/material/snack-bar";
import {ActivatedRoute, Router} from "@angular/router";
import {moveItemInArray, transferArrayItem} from "@angular/cdk/drag-drop";
import {PageEvent} from "@angular/material/paginator";
import * as XLSX from "xlsx";
import {QuestionBankService} from "../question-bank.service";

@Component({
  selector: 'app-question-bank-add',
  templateUrl: './question-bank-add.component.html',
  styleUrls: ['./question-bank-add.component.css']
})
export class QuestionBankAddComponent implements OnInit{


  id:any;
  loading:boolean = true;
  editMode:boolean=false;
  isFilterFormOpen:boolean=true;
  queryParams: { [key: string]: any } = {'verified':'True'};
  varsity_enum_dict:any;
  varsity_unit_enum_dict:any;
  excelJsonData:any;

  questionBankAddForm = new FormGroup({
    varsity: new FormControl(null, Validators.required),
    unit: new FormControl(null, Validators.required),
    year: new FormControl(null, Validators.required),
    mcq_list: new FormControl(),
    published: new FormControl( false ),
  });



  constructor(
    private questionBankService: QuestionBankService,
    private mcqService: McqService,
    private authService:AuthService,
    private snackBar: MatSnackBar,
    private router:Router,
    private route: ActivatedRoute
  ) {}

  displayedColumns = ['question','subject','chapter','categories','hardness','option_text_1','option_text_2',
    'option_text_3','option_text_4','correct_ans','explanation'];
  ngOnInit() {
    this.getConText();
    this.route.queryParamMap.subscribe(params => {
      if (params.has('id')) {
        this.id = params.get('id');
        this.editMode =true;
        this.editModeDataSet();
      }
    });
  }





  getConText(){
    this.questionBankService.getQuestionBankAddContext().subscribe({
      next: (response)=>{
        this.varsity_enum_dict = response.data.varsity_enum_dict;
        this.varsity_unit_enum_dict = response.data.varsity_unit_enum_dict;
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

  editModeDataSet(){
    this.questionBankService.getQuestionBank(this.id).subscribe({
      next: (response)=>{
        this.questionBankAddForm.patchValue(response);
      },
      error: (err)=>{
        this.snackBar.open(err.message, 'Dismiss', {
          duration: 3000, // Duration in milliseconds (3 seconds in this example)
          panelClass: 'error-snackbar' // Custom CSS class for styling error messages
        });
      },
    })
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
        console.log(jsonData);
      };
      fileReader.readAsBinaryString(file);
    }

  }

  cancelExcelFileData(){
    this.excelJsonData=null;
    location.reload();
  }





  onSubmit(): void {




    if (this.questionBankAddForm.valid) {


      let  question_bank_data: any = {
        unit:  this.questionBankAddForm.value.unit ,
        varsity: this.questionBankAddForm.value.varsity,
        year: this.questionBankAddForm.value.year,
        mcq_list: this.excelJsonData,
        published: this.questionBankAddForm.value.published!.toString(),
      };

      if(this.editMode){

        this.questionBankService.updateQuestionBank(question_bank_data,this.id).subscribe({
          next: (response)=>{
            this.questionBankAddForm.reset();
            // location.reload();
            this.snackBar.open('Package updated successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.router.navigate(['/question_bank']);

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
                this.packageForm.controls[key].setErrors({'api_error':value});
              }

            }
          },
          complete:()=>{}
        })
      }
      else{

        this.questionBankService.addNewQuestionBank(
          question_bank_data
        ).subscribe({
          next: (response)=>{
            this.questionBankAddForm.reset();
            // location.reload();
            this.snackBar.open('Package added successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.router.navigate(['/question_bank']);
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
                this.packageForm.controls[key].setErrors({'api_error':value});
              }

            }
          },
          complete:()=>{}
        });

      }

    } else {
      console.log(this.questionBankAddForm.value);
      console.log("Please fill in all required fields.");
      // location.reload();
    }
  }
}
