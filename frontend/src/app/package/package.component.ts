import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {PageEvent} from "@angular/material/paginator";
import {PackageService} from "./package.service";
// import { DatePipe } from '@angular/common';

@Component({
  selector: 'app-package',
  templateUrl: './package.component.html',
  styleUrls: ['./package.component.css']
})
export class PackageComponent implements  OnInit{

  isFilterFormOpen:boolean=false;
  count:number = 0;
  groups:any;
  queryParams: { [key: string]: any } = {};
  packageDataList:any;

  filterForm = new FormGroup({
    package_start_date: new FormControl<Date |null>( null,),
    package_end_date:  new FormControl<Date |null>( null,),
    group: new FormControl(  ),
    published: new FormControl(  ),
  });

  displayedColumns = ['id','name','group','package_start_date','package_end_date','published','details'];

  constructor(
    private packageService:PackageService,

  ) {}

  ngOnInit() {
    this.loadPackageList();
  }

  toggleFilter(){
    this.isFilterFormOpen = !this.isFilterFormOpen;
    if(this.isFilterFormOpen){
      this.getConText();
    }
  }

  onSubmitFilter(){
    if  (this.filterForm.value.group){
    this.queryParams['group'] =  this.filterForm.value.group
    }
    if  (this.filterForm.value.published){
      this.queryParams['published'] =  this.filterForm.value.published!.toString();
    }


    if  (this.filterForm.value.package_start_date){
      this.queryParams['package_start_date'] = this.filterForm.value.package_start_date?.toISOString() || '';
    }

    if(this.filterForm.value.package_end_date){
      this.queryParams['package_end_date'] =   this.filterForm.value.package_end_date?.toISOString() || '';
    }
    console.log(this.queryParams);
    this.loadPackageList();
    this.toggleFilter();
  }
  clearFilterData(){
    this.filterForm.reset();
    this.queryParams = {};
    this.loadPackageList();
    this.toggleFilter();
  }

  getConText(){
    this.packageService.getPackageAddContext().subscribe({
      next: (response)=>{
        this.groups = response.groups;
        console.log(this.groups);
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





  onToggleChange(event: any ,packageFilter:any) {
    const formData = new FormData();

    formData.append('published',event.checked);
    // console.log(formData);
    this.packageService.updatePackage(formData,packageFilter.id).subscribe({
      next: (response)=>{
        console.log(response)
      },
      error:(error)=>{
        this.loadPackageList();
        console.log(error)
      },

    })
  }


  loadPackageList(limit=25, offset =0){
    this.packageService.getPackageList(limit,offset,this.queryParams).subscribe({
      next: (response)=>{
        console.log(response.results);
        console.log(response.count);
        this.packageDataList = response.results;
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
    this.loadPackageList(pageData.pageSize,pageData.pageIndex *pageData.pageSize);
  }

}
