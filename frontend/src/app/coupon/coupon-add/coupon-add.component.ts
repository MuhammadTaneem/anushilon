import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {AuthService} from "../../auth/auth.service";
import {MatSnackBar} from "@angular/material/snack-bar";
import {ActivatedRoute, Router} from "@angular/router";
import {moveItemInArray, transferArrayItem} from "@angular/cdk/drag-drop";
import {PageEvent} from "@angular/material/paginator";
import {CouponService} from "../coupon.service";
import {PackageService} from "../../package/package.service";

@Component({
  selector: 'app-coupon-add',
  templateUrl: './coupon-add.component.html',
  styleUrls: ['./coupon-add.component.css']
})
export class CouponAddComponent implements OnInit {



  id:any;
  editMode:boolean=false;
  isFilterFormOpen:boolean=false;
  queryParams: { [key: string]: any } = {'published':'True'};
  packageDataList:any;
  selectedPackage:any=[];
  count:number=0;
  packages :any;
  groups :any;
  couponForm = new FormGroup({
    coupon_text: new FormControl(null, Validators.required),
    coupon_start_date: new FormControl( Validators.required),
    coupon_end_date: new FormControl( Validators.required),
    packages: new FormControl(),
    published: new FormControl( false ),
  });

  packageFilterForm = new FormGroup({
    package_start_date: new FormControl<Date |null>( null,),
    package_end_date:  new FormControl<Date |null>( null,),
    group: new FormControl(  ),
    published: new FormControl(  ),
  });




  constructor(
    private couponService: CouponService,
    private packageService: PackageService,
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

    if  (this.packageFilterForm.value.group){
      this.queryParams['group'] = this.packageFilterForm.value.group || '';
    }
    if  (this.packageFilterForm.value.package_start_date){
      this.queryParams['package_start_date'] = this.packageFilterForm.value.package_start_date?.toISOString() || null;
    }

    if(this.packageFilterForm.value.package_end_date){
      this.queryParams['package_end_date'] =   this.packageFilterForm.value.package_end_date?.toISOString() || null;
    }
    this.loadPackageList();
    this.toggleFilter();
  }
  clearFilterData(){
    this.packageFilterForm.reset();
    this.queryParams = {'published':'True'};
    this.loadPackageList();
    this.toggleFilter();
  }
  getConText(){
    this.couponService.getCouponAddContext().subscribe({
      next: (response)=>{
        this.packageDataList = response.data.packages;
        this.groups = response.data.groups;
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
    this.couponService.getCoupon(this.id).subscribe({
      next: (response)=>{
        this.couponForm.patchValue(response);
        this.selectedPackage=response.packages_list;
        console.log(this.couponForm);
      },
      error: (err)=>{
        this.snackBar.open(err.message, 'Dismiss', {
          duration: 3000, // Duration in milliseconds (3 seconds in this example)
          panelClass: 'error-snackbar' // Custom CSS class for styling error messages
        });
      },
    })
  }

  // isChapterChecked(subject: any, chapter: any): boolean {
  //
  //   const subjectName = subject.name;
  //   const chapterKey = chapter.key;
  //   if(this.selectedSubjects[subjectName]?.[chapterKey]){
  //     return  true;
  //   }
  //   return  false;
  //   // return this.selectedSubjects[subjectName]?.[chapterKey] === true;
  // }
  // toggleChapter(subject: string, chapter: any): void {
  //   if (!this.selectedSubjects[subject]) {
  //     this.selectedSubjects[subject] = {};
  //   }
  //
  //   if (this.selectedSubjects[subject][chapter]) {
  //     delete this.selectedSubjects[subject][chapter];
  //     if (Object.keys(this.selectedSubjects[subject]).length === 0) {
  //       delete this.selectedSubjects[subject];
  //     }
  //   } else {
  //     this.selectedSubjects[subject][chapter] = chapter;
  //   }
  // }

  loadPackageList(limit=25, offset =0){
    this.packageService.getPackageList(limit,offset,this.queryParams).subscribe({
      next: (response)=>{
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


  onSubmit(): void {


    let selectedPackageIdList:number[]= [];
    for (let i of this.selectedPackage){
      selectedPackageIdList.push(i.id);
    }
    this.couponForm


    if (this.couponForm.valid) {

      let coupon_data: any = {
        coupon_text:  this.couponForm.value.coupon_text,
        coupon_start_date:  this.couponForm.value.coupon_start_date instanceof Date ? this.couponForm.value.coupon_start_date.toISOString():  this.couponForm.value.coupon_start_date,
        coupon_end_date:  this.couponForm.value.coupon_end_date instanceof Date ? this.couponForm.value.coupon_end_date.toISOString():  this.couponForm.value.coupon_start_date,
        packages: selectedPackageIdList,
        published: this.couponForm.value.published!.toString()
      };

      if(this.editMode){

        this.couponService.updateCoupon(coupon_data,this.id).subscribe({
          next: (response)=>{
            this.couponForm.reset();
            // location.reload();
            this.snackBar.open('Package updated successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.router.navigate(['/coupon']);

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
                this.couponForm.controls[key].setErrors({'api_error':value});
              }

            }
          },
          complete:()=>{}
        })
      }
      else{

        this.couponService.addNewCoupon(
          coupon_data
        ).subscribe({
          next: (response)=>{
            this.couponForm.reset();
            // location.reload();
            this.snackBar.open('Coupon added successfully', 'Dismiss', {
              duration: 3000, // Duration in milliseconds (3 seconds in this example)
              panelClass: 'success-snackbar' // Custom CSS class for styling success messages
            });
            this.router.navigate(['/coupon']);
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
                this.couponForm.controls[key].setErrors({'api_error':value});
              }

            }
          },
          complete:()=>{}
        });

      }

    } else {
      console.log(this.couponForm.value);
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
      const packageToAdd = event.previousContainer.data[event.previousIndex];
      if (container === 'selectedPackage' && !this.isPackageAlreadySelected(packageToAdd)) {
        transferArrayItem(
          event.previousContainer.data,
          event.container.data,
          event.previousIndex,
          event.currentIndex
        );
      } else if (container !== 'selectedPackage') {
        transferArrayItem(
          event.previousContainer.data,
          event.container.data,
          event.previousIndex,
          event.currentIndex
        );
      }
    }
  }

  isPackageAlreadySelected(mcq: any): boolean {
    // @ts-ignore
    return this.selectedPackage.some((item) => item.id === mcq.id);
  }

  onChangePage(pageData: PageEvent) {
    this.loadPackageList(pageData.pageSize,pageData.pageIndex *pageData.pageSize);
  }

}
