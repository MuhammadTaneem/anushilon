from formencode import Schema, validators, Invalid


class EitherOrValidator(validators.FancyValidator):
    def validate_python(self, value, state):
        if not value.get('option_text_1') and not value.get('option_img_url_1'):
            raise Invalid('Either option_text_1 or option_img_url_1 should have a value.', value, state)
        elif not value.get('option_text_2') and not value.get('option_img_url_2'):
            raise Invalid('Either option_text_2 or option_img_url_2 should have a value.', value, state)
        elif not value.get('option_text_3') and not value.get('option_img_url_3'):
            raise Invalid('Either option_text_3 or option_img_url_3 should have a value.', value, state)
        elif not value.get('option_text_4') and not value.get('option_img_url_4'):
            raise Invalid('Either option_text_4 or option_img_url_4 should have a value.', value, state)
        elif not value.get('question') and not value.get('question_img_url'):
            raise Invalid('Either question or question_img_url should have a value.', value, state)


class McqValidator(Schema):
    question = validators.String()
    question_img_url = validators.String()
    option_text_1 = validators.String()
    option_img_url_1 = validators.String()
    option_text_2 = validators.String()
    option_img_url_2 = validators.String()
    option_text_3 = validators.String()
    option_img_url_3 = validators.String()
    option_text_4 = validators.String()
    option_img_url_4 = validators.String()
    correct_ans = validators.String(not_empty=True)
    explanation = validators.String(not_empty=True)
    explanation_img = validators.String()
    hardness = validators.String(not_empty=True)
    categories = validators.String(not_empty=True)
    subject = validators.Int(not_empty=True)
    chapter = validators.Int(not_empty=True)
    problem_setter = validators.Int(not_empty=True)
    verified = validators.Bool()
    published = validators.Bool()
    chained_validators = [EitherOrValidator()]
