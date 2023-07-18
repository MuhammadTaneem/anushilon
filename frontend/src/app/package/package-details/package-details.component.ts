import {Component, OnInit} from '@angular/core';
import {ActivatedRoute} from "@angular/router";
import {AuthService} from "../../auth/auth.service";
import {PackageService} from "../package.service";

@Component({
  selector: 'app-package-details',
  templateUrl: './package-details.component.html',
  styleUrls: ['./package-details.component.css']
})
export class PackageDetailsComponent implements OnInit{
  packageDetails: any;
  loading: boolean = true;



  constructor(
    private packageService: PackageService,
    private route: ActivatedRoute,
    private authService:AuthService
  ) {}


  ngOnInit() {
    this.route.params.subscribe(params => {
      this.loadMcq( +params['id']);
    });

  }

  onToggleChange(event: any,key:string) {
    const formData = new FormData();
    for (const key in this.packageDetails) {
      if (this.packageDetails.hasOwnProperty(key)) {
        const value = this.packageDetails[key];
        formData.append(key, value);
      }
    }
    formData.append(key,event.checked);
    formData.delete('option_img_1')
    formData.delete('option_img_2')
    formData.delete('option_img_3')
    formData.delete('option_img_4')
    formData.delete('question_img')
    formData.delete('explanation_img')
    this.packageService.updatePackage(formData,this.packageDetails.id).subscribe({
      next: (response)=>{
        console.log(response)
      },
      error:(error)=>{

        console.log(error)
      },

    })
  }


  loadMcq(id:number){
    this.packageService.getPackage(id).subscribe({
      next: (response)=>{
        console.log(response);
        this.packageDetails = response;
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

