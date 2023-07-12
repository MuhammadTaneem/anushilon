// export interface MCQType {
//   id?:number;
//   question: string;
//   questionImg: File|string|null;
//   optionText1:String|null;
//   optionImg1: File|string|null;
//   optionText2:String|null;
//   optionImg2: File|string|null;
//   optionText3:String|null;
//   optionImg3: File|string|null;
//   optionText4:String|null;
//   optionImg4: File|string|null;
//   optionText5:String|null;
//   optionImg5: File|string|null;
//   correctAns :number;
//   explanation:string;
//   explanationImg:File|string|null;
//   subject:number;
//   chapter:number;
//   hardness:number;
//   category:number;
//   problemSetter:number;
//   verified: boolean;
//   published:boolean;
// }

export interface MCQType {
  id: number;
  question: string;
  question_img: string;
  option_text_1: string;
  option_img_1: string;
  option_text_2: string;
  option_img_2: string;
  option_text_3: string;
  option_img_3: string;
  option_text_4: string;
  option_img_4: string;
  correct_ans: string;
  explanation: string;
  explanation_img: string;
  hardness: string;
  categories: string;
  subject: string;
  chapter: string;
  problem_setter: number;
  verified: boolean;
  published: boolean;
  create_date: string;
  last_edit: string;
}
