import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {Location} from "@angular/common";
import {environment} from "../../environments/environment";

@Injectable({
  providedIn: 'root'
})
export class McqService {

  BACKEND_URL = environment.apiUrl + 'mcq';

  constructor(
    private http: HttpClient,
    private router: Router,
    private location: Location,
  ) {
  }


  getMcqAddContext(){
   return  this.http.get<any>(this.BACKEND_URL+'/context',);
  }

  addNewMcq(mcqData:any,
            questionImagePreviewUrl:File,
            optionOneImagePreviewUrl:File,
            optionTwoImagePreviewUrl:File,
            optionThreeImagePreviewUrl:File,
            optionFourImagePreviewUrl:File,
            explanationImagePreviewUrl:File,
            ){
    let  formData :FormData =  new FormData();
    for (let key in mcqData) {
      formData.append(key, mcqData[key])
    }



    formData.append('question_img_url', questionImagePreviewUrl?? mcqData["question_img"]);
    formData.append('option_img_url_1', optionOneImagePreviewUrl?? mcqData["option_img_1"]);
    formData.append('option_img_url_2', optionTwoImagePreviewUrl?? mcqData["option_img_2"]);
    formData.append('option_img_url_3', optionThreeImagePreviewUrl?? mcqData["option_img_3"]);
    formData.append('option_img_url_4', optionFourImagePreviewUrl?? mcqData["option_img_4"]);
    formData.append('option_img_url_5', "");
    formData.append('explanation_img', explanationImagePreviewUrl?? mcqData["explanation_img"]);

    formData.forEach((value, key) => {
      console.log(key, value);
    });
    return this.http.post<any>(this.BACKEND_URL,formData);
  }
}
