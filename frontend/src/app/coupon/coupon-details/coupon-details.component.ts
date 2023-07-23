import {Component, OnInit} from '@angular/core';
import {ExamService} from "../../exam/exam.service";
import {ActivatedRoute} from "@angular/router";
import {CouponService} from "../coupon.service";

@Component({
  selector: 'app-coupon-details',
  templateUrl: './coupon-details.component.html',
  styleUrls: ['./coupon-details.component.css']
})
export class CouponDetailsComponent implements OnInit {
  couponDetails: any;
  loading: boolean = true;



  constructor(
    private couponService: CouponService,
    private route: ActivatedRoute,
  ) {}


  ngOnInit() {
    this.route.params.subscribe(params => {
      this.loadCoupon( +params['id']);
    });

  }

  onToggleChange(event: any,key:string) {
    const formData = new FormData();
    // for (const key in this.examDetails) {
    //   if (this.examDetails.hasOwnProperty(key)) {
    //     const value = this.examDetails[key];
    //     formData.append(key, value);
    //   }
    // }
    formData.append(key,event.checked);
    // formData.delete('mcq_list')

    this.couponService.updateCoupon(formData,this.couponDetails.id).subscribe({
      next: (response)=>{
        console.log(response)
      },
      error:(error)=>{

        console.log(error)
      },

    })
  }


  loadCoupon(id:number){
    this.couponService.getCoupon(id).subscribe({
      next: (response)=>{
        this.couponDetails = response;
        console.log(this.couponDetails);
        this.loading = false;
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


}
