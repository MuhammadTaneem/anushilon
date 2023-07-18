import {Component, OnInit} from '@angular/core';
import {PageEvent} from '@angular/material/paginator';
import {McqService} from "./mcq.service";
import {FormControl, FormGroup} from "@angular/forms";

@Component({
  selector: 'app-mcq',
  templateUrl: './mcq.component.html',
  styleUrls: ['./mcq.component.css']
})
export class McqComponent implements  OnInit {
  mcqDataList: any;
  isFilterFormOpen:boolean=false;
  subjects :any;
  category :any;
  hardness :any;
  problem_setter:any;
  selectedSubject:any;
  id:any;
  count:number = 0;
  queryParams: { [key: string]: any } = {};
  displayedColumns = ['id','question','subject','chapter','verified','details'];
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
    private mcqService:McqService

  ) {}

  ngOnInit() {
    this.loadMcqList();
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


  onToggleChange(event: any,mcq:any) {
    const formData = new FormData();
    for (const key in mcq) {
      if (mcq.hasOwnProperty(key)) {
        const value = mcq[key];
        formData.append(key, value);
      }
    }
    formData.append('verified',event.checked);
    formData.delete('option_img_1')
    formData.delete('option_img_2')
    formData.delete('option_img_3')
    formData.delete('option_img_4')
    formData.delete('question_img')
    formData.delete('explanation_img')
    formData.delete('problem_setter')
    // console.log(formData);
    this.mcqService.updateMcq(formData,mcq.id).subscribe({
      next: (response)=>{
        console.log(response)
      },
      error:(error)=>{
        this.loadMcqList();
        console.log(error)
      },

    })
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

  onChangePage(pageData: PageEvent) {
    this.loadMcqList(pageData.pageSize,pageData.pageIndex *pageData.pageSize);
  }
}
