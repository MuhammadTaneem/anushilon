from enum import Enum


def group_enum_dict():
    return {e.name: e.value for e in GroupEnum}


def package_category_enum_dict():
    return {e.name: e.value for e in PackageCategory}


def hardness_enum_dict():
    return {e.name: e.value for e in Hardness}


def category_enum_dict():
    return {e.name: e.value for e in McqCategory}


def subjects_enum_dict():
    return {
        'পদার্থ বিজ্ঞান ১ম পত্র': {
            'name': 'পদার্থ_বিজ্ঞান_১ম_পত্র',
            'value': 'পদার্থ বিজ্ঞান ১ম পত্র',
            'chapters': {
                'অধ্যায় ০১- ভৌতজগৎ ও পরিমাপ': 'অধ্যায় ০১- ভৌতজগৎ ও পরিমাপ',
                'অধ্যায় ০২- ভেক্টর': 'অধ্যায় ০২- ভেক্টর',
                'অধ্যায় ০৩- গতিবিদ্যা': 'অধ্যায় ০৩- গতিবিদ্যা',
                'অধ্যায় ০৪- নিউটনিয়ান বলবিদ্যা': 'অধ্যায় ০৪- নিউটনিয়ান বলবিদ্যা',
                'অধ্যায় ০৫- কাজ শক্তি ও ক্ষমতা': 'অধ্যায় ০৫- কাজ শক্তি ও ক্ষমতা',
                'অধ্যায় ০৬- মহাকর্ষ ও অভিকর্ষ': 'অধ্যায় ০৬- মহাকর্ষ ও অভিকর্ষা',
                'অধ্যায় ০৭- পদার্থের গাঠনিক ধর্ম': 'অঅধ্যায় ০৭- পদার্থের গাঠনিক ধর্ম',
                'অধ্যায় ০৮- পর্যাবৃত্ত গতি': 'অধ্যায় ০৮- পর্যাবৃত্ত গতি',
                'অধ্যায় ০৯- তরঙ্গ': 'অধ্যায় ০৯- তরঙ্গ',
                'অধ্যায় ১০- গ্যাসের গতি তত্ত্ব': 'অধ্যায় ১০- গ্যাসের গতি তত্ত্ব',
                'অন্যান্য': 'অন্যান্য',
            }
        },

        'পদার্থ বিজ্ঞান ২য় পত্র': {
            'name': 'পদার্থ_বিজ্ঞান_২য়_পত্র',
            'value': 'পদার্থ বিজ্ঞান ২য় পত্র',
            'chapters': {
                'অধ্যায় ০১- তাপ গতি বিদ্যা': 'অধ্যায় ০১- তাপ গতি বিদ্যা',
                'অধ্যায় ০২- স্থির তড়িৎ': 'অধ্যায় ০২- স্থির তড়িৎ',
                'অধ্যায় ০৩- চল তড়িৎ': 'অধ্যায় ০৩- চল তড়িৎ',
                'অধ্যায় ০৪- তড়িৎ প্রবাহের চৌম্বক ক্রিয়া ও চুম্বকত্ব': 'অধ্যায় ০৪- তড়িৎ প্রবাহের চৌম্বক ক্রিয়া ও চুম্বকত্ব',
                'অধ্যায় ০৫- তাড়িতচৌম্বকীয় অবেশ ও পরিবর্তী প্রবাহ': 'অধ্যায় ০৫- তাড়িতচৌম্বকীয় অবেশ ও পরিবর্তী প্রবাহ',
                'অধ্যায় ০৬- জ্যামিতিক আলোকবিজ্ঞান': 'অধ্যায় ০৬- জ্যামিতিক আলোকবিজ্ঞান',
                'অধ্যায় ০৭- ভৌত আলোকবিজ্ঞান': 'অধ্যায় ০৭- ভৌত আলোকবিজ্ঞান',
                'অধ্যায় ০৮- আধুনিক পদার্থ বিজ্ঞান': 'অধ্যায় ০৮- আধুনিক পদার্থ বিজ্ঞান',
                'অধ্যায় ০৯- পরমাণুর মডেল এবং নিউক্লিয়ার': 'অধ্যায় ০৯- পরমাণুর মডেল এবং নিউক্লিয়ার',
                'অধ্যায় ১০- সেমিকন্ডাক্টটর ও ইলেক্ট্রনিক্স': 'অধ্যায় ১০- সেমিকন্ডাক্টটর ও ইলেক্ট্রনিক্স',
                'অধ্যায় ১১- জ্যোতি বিজ্ঞান': 'অধ্যায় ১১- জ্যোতি বিজ্ঞান',
                'অন্যান্য': 'অন্যান্য',
            }
        },

        'রসায়ন ১ম পত্র': {
            'name': 'রসায়ন_১ম_পত্র',
            'value': 'রসায়ন ১ম পত্র',
            'chapters': {
                'অধ্যায় ০১- ল্যাবরেটরির নিরাপদ ব্যবহার': 'অধ্যায় ০১- ল্যাবরেটরির নিরাপদ ব্যবহার',
                'অধ্যায় ০২- গুণগত রসায়ন': 'অধ্যায় ০২- গুণগত রসায়ন',
                'অধ্যায় ০৩- মৌলের পর্যায়বৃত্ত ধর্ম ও রাসায়নিক বন্ধন': 'অধ্যায় ০৩- মৌলের পর্যায়বৃত্ত ধর্ম ও রাসায়নিক বন্ধন',
                'অধ্যায় ০৪- রাসায়নিক পরিবর্তন': 'অধ্যায় ০৪- রাসায়নিক পরিবর্তন',
                'অধ্যায় ০৫- কর্মমুখী রসায়ন': 'অধ্যায় ০৫- কর্মমুখী রসায়ন',
                'অন্যান্য': 'অন্যান্য',
            }
        },
        'রসায়ন ২য় পত্র': {
            'name': 'রসায়ন_২য়_পত্র',
            'value': 'রসায়ন ২য় পত্র',
            'chapters': {
                'অধ্যায় ০১- পরিবেশ রসায়ন': 'অধ্যায় ০১- পরিবেশ রসায়ন',
                'অধ্যায় ০২- জৈব রসায়ন': 'অধ্যায় ০২- জৈব রসায়ন',
                'অধ্যায় ০৩- পরিমাণগত রসায়ন': 'অধ্যায় ০৩- পরিমাণগত রসায়ন',
                'অধ্যায় ০৪- তড়িৎ রসায়ন': 'অধ্যায় ০৪- তড়িৎ রসায়ন',
                'অধ্যায় ০৫- অর্থনৈতিক রসায়ন': 'অধ্যায় ০৫- অর্থনৈতিক রসায়ন',
                'অন্যান্য': 'অন্যান্য',
            }
        },
        'জীববিজ্ঞান ১ম পত্র': {
            'name': 'জীববিজ্ঞান_১ম_পত্র',
            'value': 'জীববিজ্ঞান ১ম পত্র',
            'chapters': {
                'অধ্যায় ০১- কোষ ও এর গঠন': 'অধ্যায় ০১- কোষ ও এর গঠন',
                'অধ্যায় ০২- কোষ বিভাজন': 'অধ্যায় ০২- কোষ বিভাজন',
                'অধ্যায় ০৩- কোষ রসায়ন': 'অধ্যায় ০৩- কোষ রসায়ন',
                'অধ্যায় ০৪- অণুজীব': 'অধ্যায় ০৪- অণুজীব',
                'অধ্যায় ০৫- শৈবাল ও ছত্রাক': 'অধ্যায় ০৫- শৈবাল ও ছত্রাক',
                'অধ্যায় ০৬- ব্রায়োফাইটা ও টেরিডোফাইটা': 'অধ্যায় ০৬- ব্রায়োফাইটা ও টেরিডোফাইটা',
                'অধ্যায় ০৭- নগ্নবীজী ও আবৃতবীজী উদ্ভিদ': 'অধ্যায় ০৭- নগ্নবীজী ও আবৃতবীজী উদ্ভিদ',
                'অধ্যায় ০৮- টিস্যু ও টিস্যুতন্ত্র': 'অধ্যায় ০৮- টিস্যু ও টিস্যুতন্ত্র',
                'অধ্যায় ০৯- উদ্ভিদ শারীরতত্ত্': 'অধ্যায় ০৯- উদ্ভিদ শারীরতত্ত্',
                'অধ্যায় ১০- উদ্ভিদ প্রজনন': 'অধ্যায় ১০- উদ্ভিদ প্রজনন',
                'অধ্যায় ১১- জীবপ্রযুক্তি': 'অধ্যায় ১১- জীবপ্রযুক্তি',
                'অধ্যায় ১২- জীবের পরিবেশ, বিস্তার ও সংরক্ষণ': 'অধ্যায় ১২- জীবের পরিবেশ, বিস্তার ও সংরক্ষণ',
                'অন্যান্য': 'অন্যান্য',
            }
        },
        'জীববিজ্ঞান ২য় পত্র': {
            'name': 'জীববিজ্ঞান_২য়_পত্র',
            'value': 'জীববিজ্ঞান ২য় পত্র',
            'chapters': {
                'অধ্যায় ০১- প্রাণীর বিভিন্নতা ও শ্রেণিবিন্যাস': 'অধ্যায় ০১- প্রাণীর বিভিন্নতা ও শ্রেণিবিন্যাস',
                'অধ্যায় ০২- প্রাণীর পরিচিতি': 'অধ্যায় ০২- প্রাণীর পরিচিতি',
                'অধ্যায় ০৩- মানব শারীরতত্ত্ব-পরিপাক ও শোষণ': 'অধ্যায় ০৩- মানব শারীরতত্ত্ব-পরিপাক ও শোষণ',
                'অধ্যায় ০৪- মানব শারীরতত্ত্ব -রক্ত': 'অধ্যায় ০৪- মানব শারীরতত্ত্ব -রক্ত',
                'অধ্যায় ০৫- মানব শারীরতত্ত্ব-শ্বসন ও শ্বাসক্রিয়া': 'অধ্যায় ০৫- মানব শারীরতত্ত্ব-শ্বসন ও শ্বাসক্রিয়া',
                'অধ্যায় ০৬- মানব শারীরতত্ত্ব-বর্জ্য ও নিষ্কাশন': 'অধ্যায় ০৬- মানব শারীরতত্ত্ব-বর্জ্য ও নিষ্কাশন',
                'অধ্যায় ০৭- মানব শারীরতত্ত্ব-চলন ও অঙ্গচালনা': 'অধ্যায় ০৭- মানব শারীরতত্ত্ব-চলন ও অঙ্গচালনা',
                'অধ্যায় ০৮- মানব শারীরতত্ত্ব-সমন্বয় ও নিয়ন্ত্রণ': 'অধ্যায় ০৮- টমানব শারীরতত্ত্ব-সমন্বয় ও নিয়ন্ত্রণ',
                'অধ্যায় ০৯- মানব জীবনের ধারাবাহিকতা': 'অধ্যায় ০৯- মানব জীবনের ধারাবাহিকতা',
                'অধ্যায় ১০- মানবদেহের প্রতিরক্ষা': 'অধ্যায় ১০- মানবদেহের প্রতিরক্ষা',
                'অধ্যায় ১১- জিনতত্ত্ব ও বিবর্তন': 'অধ্যায় ১১- জিনতত্ত্ব ও বিবর্তন',
                'অধ্যায় ১২- প্রাণীর আচরন': 'অধ্যায় ১২- প্রাণীর আচরন',
                'অন্যান্য': 'অন্যান্য',
            }
        },

    }


class GroupEnum(Enum):
    arts = 'Arts'
    science = 'Science'
    commerce = 'Commerce'


class UserRole(Enum):
    admin = 'Admin'
    super_admin = 'Super Admin'
    problem_setter = 'Problem Setter'
    student = 'Student'


class Hardness(Enum):
    easy = "Easy"
    medium = "Medium"
    hard = "Hard"
    super_hard = "Super Hard"


class McqCategory(Enum):
    theoretical = "Theoretical"
    mathematical = "Mathematical"
    critical = "Critical"
    high_important = "High Important"
    medium_important = "Medium Important"
    low_important = "Low Important"


class PackageCategory(Enum):
    varsity = "Varsity"
    medical = "Medical"
    engineering = "Engineering"
    free_exam = "Free Exam"
    hsc = "Hsc"
    guccho = "Guccho"
