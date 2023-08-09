import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {McqService} from "../mcq/mcq.service";
import {PageEvent} from "@angular/material/paginator";
import {QuestionBankService} from "./question-bank.service";

@Component({
  selector: 'app-question-bank',
  templateUrl: './question-bank.component.html',
  styleUrls: ['./question-bank.component.css']
})
export class QuestionBankComponent implements  OnInit {
  questionBankDataList: any;
  isFilterFormOpen:boolean=false;
  varsity_enum_dict:any;
  varsity_unit_enum_dict:any;
  id:any;
  count:number = 0;
  queryParams: { [key: string]: any } = {};
  displayedColumns = ['id','varsity','unit','year','published','details'];

  filterForm = new FormGroup({
    varsity: new FormControl(null, Validators.required),
    unit: new FormControl(null, Validators.required),
    year: new FormControl(null, Validators.required),
    published: new FormControl(  ),
  });

  constructor(
    private questionBankService:QuestionBankService

  ) {}

  ngOnInit() {
    this.loadQuestionBankList();
  }


  toggleFilter(){
    this.isFilterFormOpen = !this.isFilterFormOpen;
    if(this.isFilterFormOpen){
      this.getConText();
    }
  }

  onToggleChange(event: any ,packageFilter:any) {
    const formData = new FormData();
    formData.append('published',event.checked);
    // console.log(formData);
    this.questionBankService.updateQuestionBank(formData,packageFilter.id).subscribe({
      next: (response)=>{
        console.log(response)
      },
      error:(error)=>{
        this.loadQuestionBankList();
        console.log(error)
      },

    })
  }


  onSubmitFilter(){

    if(this.filterForm.value.unit){
      this.queryParams['unit'] =   this.filterForm.value.unit;
    }
    if(this.filterForm.value.varsity){
      this.queryParams['varsity'] =   this.filterForm.value.varsity;
    }
    if(this.filterForm.value.year){
      this.queryParams['year'] =   this.filterForm.value.year;
    }
    if(this.filterForm.value.published != null){
      this.queryParams['published'] =   this.filterForm.value.published!.toString();
    }
    console.log(this.queryParams);
    this.loadQuestionBankList();
    this.toggleFilter();
  }
  clearFilterData(){
    this.filterForm.reset();
    this.queryParams = {};
    this.loadQuestionBankList();
    this.toggleFilter();
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





  loadQuestionBankList(limit=25, offset =0){
    this.questionBankService.getQuestionBankList(limit,offset,this.queryParams).subscribe({
      next: (response)=>{
        this.questionBankDataList = response.results;
        console.log(this.questionBankDataList);
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
    this.loadQuestionBankList(pageData.pageSize,pageData.pageIndex *pageData.pageSize);
  }
}
