import {Component, OnInit} from '@angular/core';
import {McqService} from "../mcq.service";
import {AuthService} from "../../auth/auth.service";
import {ActivatedRoute} from "@angular/router";

@Component({
  selector: 'app-mac-details',
  templateUrl: './maq-details.component.html',
  styleUrls: ['./maq-details.component.css']
})
export class MaqDetailsComponent implements OnInit {
  question: any;
  loading: boolean = true;



  constructor(
    private mcqService: McqService,
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
    for (const key in this.question) {
      if (this.question.hasOwnProperty(key)) {
        const value = this.question[key];
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
    this.mcqService.updateMcq(formData,this.question.id).subscribe({
      next: (response)=>{
        console.log(response)
      },
      error:(error)=>{

        console.log(error)
      },

    })
  }


  loadMcq(id:number){
    this.mcqService.getMcq(id).subscribe({
      next: (response)=>{
        console.log(response);
        this.question = response;
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
