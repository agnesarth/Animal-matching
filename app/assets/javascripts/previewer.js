$(function() {
  $('.uploadPreview').on('change', function(event) {
    console.log("ok");
    var files = event.target.files;
    for (i = 0; i < files.length; i++){
      var image = files[i]
      var reader = new FileReader();
      reader.onload = function(file) {
        var img = new Image();
        img.width = "200";
        img.height = "200";
        img.style.margin = "10px";
        img.classList.add("form-border")
        img.classList.add("lined-thick")
        console.log(file);
        img.src = file.target.result;
        $('#showPreview').append(img);
      }
      reader.readAsDataURL(image);
    }
    console.log(files);
  });
});
