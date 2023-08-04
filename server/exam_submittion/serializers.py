from rest_framework import serializers
from rest_framework.utils import json
# import json


from .models import ExamSubmission, MCQSubmission


class MCQSubmissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = MCQSubmission
        fields = '__all__'


class ExamSubmissionSerializer(serializers.ModelSerializer):
    mcq_submissions = MCQSubmissionSerializer(many=True, required=False)

    class Meta:
        model = ExamSubmission
        fields = '__all__'

    def create(self, validated_data):
        mcq_submissions_data_str = self.initial_data.get('mcq_submissions', '[]')
        mcq_submissions_data = json.loads(mcq_submissions_data_str)

        exam_submission = ExamSubmission.objects.create(**validated_data)
        total_point = 0
        total_penalty = 0

        for mcq_submission_data in mcq_submissions_data:
            mcq = mcq_submission_data['mcq']
            submitted_option = mcq_submission_data['submitted_option']
            mcq_submission = MCQSubmission.objects.create(exam_submission=exam_submission, mcq_id=mcq,
                                                          submitted_option=submitted_option)
            if mcq_submission.mcq.correct_ans == submitted_option:
                total_point += exam_submission.exam.point
            else:
                total_penalty += exam_submission.exam.penalty

        exam_submission.point = total_point
        exam_submission.penalty = total_penalty
        exam_submission.save()

        return exam_submission
