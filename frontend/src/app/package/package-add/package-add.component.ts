import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {AuthService} from "../../auth/auth.service";
import {MatSnackBar} from "@angular/material/snack-bar";
import {ActivatedRoute, Router} from "@angular/router";
import {PackageService} from "../package.service";

@Component({
  selector: 'app-package-add',
  templateUrl: './package-add.component.html',
  styleUrls: ['./package-add.component.css']
})
export class PackageAddComponent  implements OnInit{

  groups:any;
  editMode:boolean = false;
  id:any;

  packageForm = new FormGroup({
    name: new FormControl('', [Validators.required]),
    description: new FormControl('', [Validators.required]),
    price: new FormControl('', [Validators.required]),
    discount_amount: new FormControl(''),
    number_of_exam: new FormControl('', [Validators.required]),
    discount_start_date: new  FormControl<Date | null>(null),
    discount_end_date:  new FormControl<Date | null>(null),
    package_start_date: new FormControl<Date |null>( null,[Validators.required]),
    package_end_date:  new FormControl<Date |null>( null,[Validators.required]),
    group: new FormControl('', [Validators.required]),
    published: new FormControl( false ),
  });


  constructor(
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


  getConText(){
    this.packageService.getPackageAddContext().subscribe({
      next: (response)=>{
        this.groups = response.groups;
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
    this.packageService.getPackage(this.id).subscribe({
      next: (response)=>{
        this.packageForm.patchValue(response);
      },
      error: (err)=>{
        this.snackBar.open(err.message, 'Dismiss', {
          duration: 3000, // Duration in milliseconds (3 seconds in this example)
          panelClass: 'error-snackbar' // Custom CSS class for styling error messages
        });
      },
    })
  }

  onSubmit(): void {
    if (this.packageForm.valid) {

      let formData:FormData = new FormData()


      formData.append('name', this.packageForm.value.name || '');
      formData.append('price', this.packageForm.value.price || '');
      formData.append('description', this.packageForm.value.description || '');
      formData.append('discount_amount', this.packageForm.value.discount_amount || '');
      formData.append('number_of_exam', this.packageForm.value.number_of_exam || '');

      formData.append('group', this.packageForm.value.group || '');
      formData.append('published', this.packageForm.value.published!.toString());
      formData.append('discount_start_date', this.packageForm.value.discount_start_date instanceof Date ? this.packageForm.value.discount_start_date.toISOString() : `${this.packageForm.value.discount_start_date}`);
      formData.append('discount_end_date', this.packageForm.value.discount_end_date instanceof Date ? this.packageForm.value.discount_end_date.toISOString() : `${this.packageForm.value.discount_end_date}`);
      formData.append('package_start_date', this.packageForm.value.package_start_date instanceof Date ? this.packageForm.value.package_start_date.toISOString() : `${this.packageForm.value.package_start_date}`);
      formData.append('package_end_date', this.packageForm.value.package_end_date instanceof Date ? this.packageForm.value.package_end_date.toISOString() : `${this.packageForm.value.package_end_date}`);



      if(this.editMode){

        this.packageService.updatePackage(formData,this.id).subscribe({
          next: (response)=>{
            this.packageForm.reset();
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

        this.packageService.addNewPackage(
          formData
        ).subscribe({
          next: (response)=>{
            this.packageForm.reset();
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
      console.log(this.packageForm.value);
      console.log("Please fill in all required fields.");
      // location.reload();
    }
  }



}
