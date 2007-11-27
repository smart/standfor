// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function ValidateDonationForm(form, min)
{
   if (form.order_amount.value * 1 < min * 1) {
      alert('This badge requires a minimum donation $' + min + '.' ) 
      form.order_amount.focus(); 
      return false; 
  } 
    return true;

} 
