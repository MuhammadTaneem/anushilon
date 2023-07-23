import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup} from "@angular/forms";
import {ExamService} from "../exam/exam.service";
import {PageEvent} from "@angular/material/paginator";
import {PackageService} from "../package/package.service";
import {CouponService} from "./coupon.service";

@Component({
  selector: 'app-coupon',
  templateUrl: './coupon.component.html',
  styleUrls: ['./coupon.component.css']
})
export class CouponComponent implements  OnInit{


  isFilterFormOpen :boolean = false;
  id:any;
  count:number = 0;
  packages:any;
  couponDataList:any;
  queryParams: { [key: string]: any } = {};
  displayedColumns = ['id','coupon_text','published','coupon_start_date','coupon_end_date','details'];
  // filterForm = new FormGroup({
  //   package: new FormControl(),
  //   published: new FormControl(),
  //   from_exam_date: new FormControl<Date |null>( null,),
  //   to_exam_date: new FormControl<Date |null>( null,),
  // });

  constructor(
    private couponService:CouponService

  ) {}

  ngOnInit() {
    this.loadCouponList();
  }




  toggleFilter(){
    this.isFilterFormOpen = !this.isFilterFormOpen;
    if(this.isFilterFormOpen){
      this.getConText();
    }
  }

  // onSubmitFilter(){
  //   Object.keys(this.filterForm.controls).forEach((key:string) => {
  //     const control = this.filterForm.get(key);
  //     if (control!.value) {
  //       this.queryParams[key] = control!.value;
  //     }
  //   });
  //   if  (this.filterForm.value.from_exam_date){
  //     this.queryParams['from_exam_date'] = this.filterForm.value.from_exam_date?.toISOString() || '';
  //   }
  //   if  (this.filterForm.value.to_exam_date){
  //     this.queryParams['to_exam_date'] = this.filterForm.value.to_exam_date?.toISOString() || '';
  //   }
  //   console.log(this.queryParams);
  //   this.loadCouponList();
  //   this.toggleFilter();
  // }
  // clearFilterData(){
  //   this.filterForm.reset();
  //   this.queryParams = {};
  //   this.loadCouponList();
  //   this.toggleFilter();
  // }
  getConText(){
    this.couponService.getCouponAddContext().subscribe({
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

  loadCouponList(limit=25, offset =0){
    this.couponService.getCouponList(limit,offset,this.queryParams).subscribe({
      next: (response)=>{

        this.couponDataList = response.results;
        console.log(this.couponDataList);
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
    this.loadCouponList(pageData.pageSize,pageData.pageIndex *pageData.pageSize);
  }
}
