import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {ExamService} from "../exam.service";
import {AuthService} from "../../auth/auth.service";
import {MatSnackBar} from "@angular/material/snack-bar";
import {ActivatedRoute, Router} from "@angular/router";
import {McqService} from "../../mcq/mcq.service";
import {
  moveItemInArray,
  transferArrayItem,
} from '@angular/cdk/drag-drop';
import {PageEvent} from "@angular/material/paginator";
@Component({
  selector: 'app-exam-add',
  templateUrl: './exam-add.component.html',
  styleUrls: ['./exam-add.component.css']
})
export class ExamAddComponent implements OnInit{

  selectedSubjects: any = {};


  id:any;
  loading:boolean = true;
  editMode:boolean=false;
  isFilterFormOpen:boolean=true;
  queryParams: { [key: string]: any } = {'verified':'True'};
  selectedSubject:any;
  mcqDataList:any;
  selectedMcq:any=[];
  count:number=0;
  subjects :any;
  packages :any;
  category:any;
  hardness:any;
  problem_setter:any;
  examForm = new FormGroup({
    syllabus: new FormControl(null, Validators.required),
    exam_number: new FormControl(null, Validators.required),
    number_of_question: new FormControl(null, Validators.required),
    duration: new FormControl(null, Validators.required),
    point: new FormControl(null, Validators.required),
    exam_date: new FormControl(Validators.required),
    package: new FormControl( Validators.required),
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
    private examService: ExamService,
    private mcqService: McqService,
    private authService:AuthService,
    private snackBar: MatSnackBar,
    private router:Router,
    private route: ActivatedRoute
  ) {}


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

  toggleFilter(){
    this.isFilterFormOpen = !this.isFilterFormOpen;
    // if(this.isFilterFormOpen){
    //   this.getConText();
    // }
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
  getConText(){
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

  editModeDataSet(){
    this.examService.getExam(this.id).subscribe({
      next: (response)=>{
        this.examForm.patchValue(response);
        this.examForm.controls['package'].setValue(response.package.toString());
        this.selectedSubjects = JSON.parse(response.syllabus);
        this.selectedMcq=response.mcq_list_value;
      },
      error: (err)=>{
        this.snackBar.open(err.message, 'Dismiss', {
          duration: 3000, // Duration in milliseconds (3 seconds in this example)
          panelClass: 'error-snackbar' // Custom CSS class for styling error messages
        });
      },
    })
  }

  isChapterChecked(subject: any, chapter: any): boolean {

    const subjectName = subject.name;
    const chapterKey = chapter.key;
    if(this.selectedSubjects[subjectName]?.[chapterKey]){
    return  true;
    }
    return  false;
    // return this.selectedSubjects[subjectName]?.[chapterKey] === true;
  }
  toggleChapter(subject: string, chapter: any): void {
    if (!this.selectedSubjects[subject]) {
      this.selectedSubjects[subject] = {};
    }

    if (this.selectedSubjects[subject][chapter]) {
      delete this.selectedSubjects[subject][chapter];
      if (Object.keys(this.selectedSubjects[subject]).length === 0) {
        delete this.selectedSubjects[subject];
      }
    } else {
      this.selectedSubjects[subject][chapter] = chapter;
    }
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

  onSubmit(): void {

    if(this.selectedSubjects){
    // @ts-ignore
      this.examForm.controls.syllabus.setValue(JSON.stringify(this.selectedSubjects));
    }

    let mcqIdList:number[]= [];
    for (let i of this.selectedMcq){

      mcqIdList.push(i.id);
    }
    let exam_Date;

    if (this.examForm.valid) {
      if(this.examForm.value.exam_date instanceof Date){
        exam_Date =   this.examForm.value.exam_date.toISOString();
      }

     let  exam_data: any = {
        syllabus:  this.examForm.value.syllabus,
        exam_number: this.examForm.value.exam_number,
        number_of_question: this.examForm.value.number_of_question,
        duration: this.examForm.value.duration,
        point: this.examForm.value.point,
        exam_date: exam_Date,
        package: this.examForm.value.package,
        mcq_list: mcqIdList,
        published: this.examForm.value.published!.toString()
      };

      if(this.editMode){

        this.examService.updateExam(exam_data,this.id).subscribe({
          next: (response)=>{
            this.examForm.reset();
            // location.reload();
            this.snackBar.open('Package updated successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.router.navigate(['/exam']);

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

        this.examService.addNewExam(
          exam_data
        ).subscribe({
          next: (response)=>{
            this.examForm.reset();
            // location.reload();
            this.snackBar.open('Package added successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.router.navigate(['/exam']);
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
      console.log(this.examForm.value);
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

  onChangePage(pageData: PageEvent) {
    this.loadMcqList(pageData.pageSize,pageData.pageIndex *pageData.pageSize);
  }

}
