import pathlib
from django.shortcuts import render
# from django.http import HttpResponse
from visits.models import PageVisit
this_dir = pathlib.Path(__file__).resolve().parent






def home_view(request, *args,**kwargs):
   return about_view(request,*args,**kwargs)


def about_view(request,*args,**kwargs):
   qs=PageVisit.objects.all()
   page_qs=PageVisit.objects.filter(path=request.path)

   my_title="Hello akanksha its working"
   my_content={
      "page_title":my_title,
      "pagevisit_count":page_qs.count(),
      "total_visit_count":qs.count(),
            }
  
   html_template="home.html"
   PageVisit.objects.create(path=request.path)
   return render(request,html_template,my_content)
   


# --------------------------------------------------------- OLD HOME PAGE TRAIL  TEMPLATE COPY ------------------------------------------------------------------
# def old_home_page_view(request, *args,**kwargs):
#    my_title="Homepage"
#    my_content={
#       "page_title":my_title,
         
#             }
#    html_="""
# <!DOCTYPE html>
# <html lang="en">
# <head>
#     <meta charset="UTF-8">
#     <meta name="viewport" content="width=device-width, initial-scale=1.0">
#     <title>Document</title>
# </head>
# <body>
#     <h1>{page_title}</h1>
# </body>
# </html>

# """.format(**my_content)
# #    html_file_path=this_dir/"home.html"
# #    html_=html_file_path.read_text()
#    return HttpResponse(html_)
 

  