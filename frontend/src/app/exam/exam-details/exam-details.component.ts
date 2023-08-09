import {Component, OnInit} from '@angular/core';
import {ActivatedRoute} from "@angular/router";
import {AuthService} from "../../auth/auth.service";
import {ExamService} from "../exam.service";

@Component({
  selector: 'app-exam-details',
  templateUrl: './exam-details.component.html',
  styleUrls: ['./exam-details.component.css']
})
export class ExamDetailsComponent implements OnInit {
  examDetails: any;
  loading: boolean = true;



  constructor(
    private examService: ExamService,
    private route: ActivatedRoute,
  ) {}


  ngOnInit() {
    this.route.params.subscribe(params => {
      this.loadExam( +params['id']);
    });

  }

  onToggleChange(event: any,key:string) {
    const formData = new FormData();
    formData.append(key,event.checked);
    this.examService.updateExam(formData,this.examDetails.id).subscribe({
      next: (response)=>{
        console.log(response)
      },
      error:(error)=>{

        console.log(error)
      },

    })
  }


  loadExam(id:number){
    this.examService.getExam(id).subscribe({
      next: (response)=>{
        this.examDetails = response;
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
