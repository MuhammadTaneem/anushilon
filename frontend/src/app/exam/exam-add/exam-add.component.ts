import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {ExamService} from "../exam.service";
import {AuthService} from "../../auth/auth.service";
import {MatSnackBar} from "@angular/material/snack-bar";
import {ActivatedRoute, Router} from "@angular/router";
import {McqService} from "../../mcq/mcq.service";
import {
  CdkDragDrop,
  moveItemInArray,
  transferArrayItem,
  CdkDrag,
  CdkDropList,
} from '@angular/cdk/drag-drop';
@Component({
  selector: 'app-exam-add',
  templateUrl: './exam-add.component.html',
  styleUrls: ['./exam-add.component.css']
})
export class ExamAddComponent implements OnInit{

  selectedSubjects: any = {};


  id:any;
  editMode:boolean=false;
  isFilterFormOpen:boolean=true;
  queryParams: { [key: string]: any } = {};
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
    package: new FormControl(null, Validators.required),
    mcq_list: new FormControl(),
    published: new FormControl( false ),
  });

  filterForm = new FormGroup({
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
    if(this.isFilterFormOpen){
      this.getConText();
    }
  }

  onSubmitFilter(){
    Object.keys(this.filterForm.controls).forEach((key:string) => {
      const control = this.filterForm.get(key);
      if (control!.value) {
        this.queryParams[key] = control!.value;
      }
    });
    if  (this.filterForm.value.create_start_date){
      this.queryParams['create_start_date'] = this.filterForm.value.create_start_date?.toISOString() || '';
    }

    if(this.filterForm.value.create_end_date){
      this.queryParams['create_end_date'] =   this.filterForm.value.create_end_date?.toISOString() || '';
    }
    console.log(this.queryParams);
    this.loadMcqList();
    this.toggleFilter();
  }
  clearFilterData(){
    this.filterForm.reset();
    this.queryParams = {};
    this.loadMcqList();
    this.toggleFilter();
  }
  getConText(){
    this.examService.getExamAddContext().subscribe({
      next: (response)=>{
        console.log(response)
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

    console.log(this.selectedSubjects);
  }

  loadMcqList(limit=25, offset =0){
    this.mcqService.getMcqList(limit,offset,this.queryParams).subscribe({
      next: (response)=>{
        console.log(response.results);
        console.log(response.count);
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
      this.filterForm.get('chapter')?.enable();
    } else {
      this.filterForm.get('chapter')?.disable();
    }
  }



  onSubmit(): void {
    this.examForm.controls.syllabus.setValue(this.selectedSubjects);

    let mcqIdList = [];

    for (let i of this.selectedMcq){
      mcqIdList.push(i.id);
    }

    if (this.examForm.valid) {
      let formData:FormData = new FormData()
      formData.append('syllabus', this.selectedSubjects || '');
      formData.append('exam_number', this.examForm.value.exam_number || '');
      formData.append('number_of_question', this.examForm.value.number_of_question || '');
      formData.append('duration', this.examForm.value.duration || '');
      formData.append('point', this.examForm.value.point || '');
      formData.append('package', this.examForm.value.package || '');
      formData.append('mcq_list', mcqIdList.join(','));
      formData.append('published', this.examForm.value.published!.toString());
      formData.append('exam_date', this.examForm.value.exam_date instanceof Date ? this.examForm.value.exam_date.toISOString() : `${this.examForm.value.exam_date}`);





      if(this.editMode){

        this.examService.updateExam(formData,this.id).subscribe({
          next: (response)=>{
            this.examForm.reset();
            // location.reload();
            this.snackBar.open('Package updated successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.router.navigate(['/package']);

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
          formData
        ).subscribe({
          next: (response)=>{
            this.examForm.reset();
            // location.reload();
            this.snackBar.open('Package added successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.router.navigate(['/package']);
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



  drop(event: any) {
    if (event.previousContainer === event.container) {
      moveItemInArray(
        event.container.data,
        event.previousIndex,
        event.currentIndex
      );
    } else {
      transferArrayItem(
        event.previousContainer.data,
        event.container.data,
        event.previousIndex,
        event.currentIndex
      );
    }
  }






}
