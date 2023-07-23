import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {McqService} from "../mcq/mcq.service";
import {ExamService} from "./exam.service";
import {PageEvent} from "@angular/material/paginator";

@Component({
  selector: 'app-exam',
  templateUrl: './exam.component.html',
  styleUrls: ['./exam.component.css']
})
export class ExamComponent implements  OnInit{


  isFilterFormOpen :boolean = false;
  id:any;
  count:number = 0;
  packages:any;
  examDataList:any;
  queryParams: { [key: string]: any } = {};
  displayedColumns = ['id','package','exam_number','exam_date','published','details'];
  filterForm = new FormGroup({
    package: new FormControl(),
    published: new FormControl(),
    from_exam_date: new FormControl<Date |null>( null,),
    to_exam_date: new FormControl<Date |null>( null,),
  });

  constructor(
    private examService:ExamService

  ) {}

  ngOnInit() {
    this.loadExamList();
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
    if  (this.filterForm.value.from_exam_date){
      this.queryParams['from_exam_date'] = this.filterForm.value.from_exam_date?.toISOString() || '';
    }
    if  (this.filterForm.value.to_exam_date){
      this.queryParams['to_exam_date'] = this.filterForm.value.to_exam_date?.toISOString() || '';
    }
    console.log(this.queryParams);
    this.loadExamList();
    this.toggleFilter();
  }
  clearFilterData(){
    this.filterForm.reset();
    this.queryParams = {};
    this.loadExamList();
    this.toggleFilter();
  }
  getConText(){
    this.examService.getExamAddContext().subscribe({
      next: (response)=>{
        console.log(response)
        this.packages = response.data.packages;
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

  loadExamList(limit=25, offset =0){
    this.examService.getExamList(limit,offset,this.queryParams).subscribe({
      next: (response)=>{
        this.examDataList = response.results;
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
    this.loadExamList(pageData.pageSize,pageData.pageIndex *pageData.pageSize);
  }
}
