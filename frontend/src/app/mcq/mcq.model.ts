export interface MCQType {
  id?:number;
  question: string;
  questionImg: File|string|null;
  optionText1:String|null;
  optionImg1: File|string|null;
  optionText2:String|null;
  optionImg2: File|string|null;
  optionText3:String|null;
  optionImg3: File|string|null;
  optionText4:String|null;
  optionImg4: File|string|null;
  optionText5:String|null;
  optionImg5: File|string|null;
  correctAns :number;
  explanation:string;
  explanationImg:File|string|null;
  subject:number;
  chapter:number;
  hardness:number;
  category:number;
  problemSetter:number;
  verified: boolean;
  published:boolean;
}

