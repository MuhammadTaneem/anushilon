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
  mcqDataList:any=[];
  selectedMcq:any=[];
  selectedSubject:any;
  count: any;
  subjects :any;
  packages :any;
  category:any;
  hardness:any;
  problem_setter:any;

  questionBankAddForm = new FormGroup({
    varsity: new FormControl(null, Validators.required),
    unit: new FormControl(null, Validators.required),
    year: new FormControl(null, Validators.required),
    mcq_list: new FormControl(),
    published: new FormControl( false ),
  });

  mcqFilterForm = new FormGroup({
    subject: new FormControl(),
    chapter: new FormControl({ value: null,disabled: true }),
    hardness: new FormControl(), // Add Validators.required
    categories: new FormControl(),
    problem_setter: new FormControl(),
    verified: new FormControl(  ),
    published: new FormControl(  ),
    create_start_date: new FormControl<Date |null>( null,),
    create_end_date:  new FormControl<Date |null>( null,),
  });



  constructor(
    private questionBankService: QuestionBankService,
    private mcqService: McqService,
    private examService: ExamService,
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
        this.getMcqConText();
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
        this.selectedMcq=response.mcq_list;
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
  toggleFilter(){
    this.isFilterFormOpen = !this.isFilterFormOpen;
    // if(this.isFilterFormOpen){
    //   this.getConText();
    // }
  }
  selectSubjectChange(event:any){
    // @ts-ignore
    this.selectedSubject = this.subjects.find(subject=> subject.name === event.value);
    this.selectedSubject = this.selectedSubject.chapters;
    if (this.selectedSubject) {
      this.mcqFilterForm.get('chapter')?.enable();
    } else {
      this.mcqFilterForm.get('chapter')?.disable();
    }
  }
  onSubmitFilter(){
    Object.keys(this.mcqFilterForm.controls).forEach((key:string) => {
      const control = this.mcqFilterForm.get(key);
      if (control!.value) {
        this.queryParams[key] = control!.value;
      }
    });
    if  (this.mcqFilterForm.value.create_start_date){
      this.queryParams['create_start_date'] = this.mcqFilterForm.value.create_start_date?.toISOString() || '';
    }

    if(this.mcqFilterForm.value.create_end_date){
      this.queryParams['create_end_date'] =   this.mcqFilterForm.value.create_end_date?.toISOString() || '';
    }
    this.loadMcqList();
    this.toggleFilter();
  }
  clearFilterData(){
    this.mcqFilterForm.reset();
    this.queryParams = {'verified':'True'};
    this.loadMcqList();
    this.toggleFilter();
  }

  getMcqConText(){
    this.examService.getExamAddContext().subscribe({
      next: (response)=>{
        this.subjects = Object.values(response.data.subjects);
        this.packages = response.data.packages;
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



  onSubmit(): void {




    if (this.questionBankAddForm.valid) {


      let mcqIdList:number[]= [];
      for (let i of this.selectedMcq){
        mcqIdList.push(i.id);
      }

      let  question_bank_data: any = {
        unit:  this.questionBankAddForm.value.unit ,
        varsity: this.questionBankAddForm.value.varsity,
        year: this.questionBankAddForm.value.year,
        mcq_list: this.editMode? this.selectedMcq : this.excelJsonData,
        published: this.questionBankAddForm.value.published!.toString(),
      };

      console.log(question_bank_data)
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

  drop(event: any,container:string) {
    if (event.previousContainer === event.container) {
      moveItemInArray(
        event.container.data,
        event.previousIndex,
        event.currentIndex
      );
    } else {
      const mcqToAdd = event.previousContainer.data[event.previousIndex];
      if (container === 'selectedMcq' && !this.isMcqAlreadySelected(mcqToAdd)) {
        transferArrayItem(
          event.previousContainer.data,
          event.container.data,
          event.previousIndex,
          event.currentIndex
        );
      } else if (container !== 'selectedMcq') {
        transferArrayItem(
          event.previousContainer.data,
          event.container.data,
          event.previousIndex,
          event.currentIndex
        );
      }
    }
  }

  isMcqAlreadySelected(mcq: any): boolean {
    // @ts-ignore
    return this.selectedMcq.some((item) => item.id === mcq.id);
  }
  loadMcqList(limit=25, offset =0){
    this.mcqService.getMcqList(limit,offset,this.queryParams).subscribe({
      next: (response)=>{
        this.mcqDataList = response.results;
        this.count = response.count;

      },
      error: (err)=>{
        console.log(err.status_code);
        console.log(err.error);
        console.log(err.error.status);
        console.log(err.error.errors);
        console.log(err.error.message);
      },
      complete:()=>{}
    })
  }
  onChangePage(pageData: PageEvent) {
    this.loadMcqList(pageData.pageSize,pageData.pageIndex *pageData.pageSize);
  }
}
