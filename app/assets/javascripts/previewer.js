$(function() {
  $('.uploadPreview').on('change', function(event) {
    console.log("ok");
    var files = event.target.files;
    for (i = 0; i < files.length; i++){
      var image = files[i]
      var reader = new FileReader();
      reader.onload = function(file) {
        var img = new Image();
        img.width = "150"
        img.height = "200"
        img.style.margin = "10px"
        console.log(file);
        img.src = file.target.result;
        $('#showPreview').append(img);
      }
      reader.readAsDataURL(image);
    }
    console.log(files);
  });
});
