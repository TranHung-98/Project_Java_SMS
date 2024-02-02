$(document).ready(function () {

    const addEmployeeBtn = $('#btn-add-employee');
    const elementInput = $('#first_name, #birth, #phone, #last_name, #account, #email, #password, #department,#female,#male');

// Validation for all fields on form submission
    addEmployeeBtn.on('click',function (event) {
        event.preventDefault();
        if(elementInput.val() === '') {
            validateEmployeeForm();
        } else if (!validateFormAdd()) {
            event.preventDefault();
        } else {
            $(this).submit();
            $('#form-add').submit();
        }

    });

// Validation for individual form fields on blur event
    elementInput.on("blur", function () {
        handleValidation($(this));
    });
// Xử lý khi  có dữ liệu
    elementInput.on('input', function () {
        handleValidation($(this));
    });

// Validation for gender on radio button click
    $('input[name="gender"]').on('click', function () {
        let genderSelected = $('input[name="gender"]:checked').length > 0;

        if (!genderSelected) {
            $('#gender-error').text('Please select a gender').show();
        } else {
            $('#gender-error').hide();
        }
    });



// Reset form function
    $(document).on('click', "#reset-value", function () {

        let selectors = $('#first_name, #birth, #phone, #last_name, #account, #email, #address, #password, #department, #remark');

        // Assuming these are the IDs of your form elements
        selectors.val('');
        $('input[name="gender"]').prop('checked', false);

        // Reset borders
       selectors.css("border", "");

        // Hide error messages
        msg.text('').hide();
    });

})


// Consolidated validation function
function handleValidation(element) {
    let errorMessageElement = element.next('.error-message');

    if (element.val().trim() === '') {
        errorMessageElement.text('Please enter this field!').show();
        element.css("border", "1px solid red");
    } else {
        errorMessageElement.text('');
        element.css("border", "1px solid #155FEE");
    }

}

function validateEmployeeForm() {
    let fields = $('#first_name, #birth, #phone, #last_name, #account, #email, #password, #department');
    let genderSelected = $('input[name="gender"]:checked').length > 0;

    // Validate gender
    if (!genderSelected) {
        $('#gender-error').text('Please select a gender').show();
    } else {
        $('#gender-error').hide();
    }

    // Validate individual fields
    fields.each(function () {
        handleValidation($(this));
    });

    // Validate status checkbox
    let checkboxSelected = $('input[name="Active"]:checked').length > 0;
    if (!checkboxSelected) {
        $('#status-error').text('Please check the status').show();
    } else {
        $('#status-error').hide();
    }

    let isValid = true;

    fields.each(function () {
        if ($(this).val().trim() === '') {
            isValid = false;
            return false;
        }
    });

    if (isValid) {
        $('#form-add').submit();
    }else {
        event.preventDefault();
    }
}

function validateFormAdd() {

    let vietnameseWithoutDiacriticsPattern = /^[a-zA-Z\s]+$/;
    let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    let vnPattern = /^(0[1-9]|84[1-9])[0-9]{3,}$/;
    let checkPhoneRegex = /^\+\d{1,4}[0-9]{6,}$/;
    let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$/;
    let englishWithNumbersAndSpecialCharsPattern = /^[a-zA-Z0-9!@#$%^&*+()]*$/;
    let addressFormatRegex = /^[a-zA-Z0-9@#$%^&+=!\s-]*$/;


    let inputEmail = $('#email').val();
    let inputPhone = $('#phone').val();
    let inputFirstName = $('#first_name').val();
    let inputLastName = $('#last_name').val();
    let inputAccount = $('#account').val();
    let addressCheck = $('#address').val();
    let remarkCheck = $('#remark').val();
    let checkPassword = $('#password').val();


    if (!englishWithNumbersAndSpecialCharsPattern.test(inputAccount)) {
        alert('Please do not enter accented Vietnamese account and contain "a-zA-Z0-9!@#$%^&*+()"')
    }

    if (addressCheck.trim() !== '' && !addressFormatRegex.test(addressCheck)) {
        alert('Address should be formatted as "Số nhà-Phố-Xã/Quận-Huyện-Tỉnh/Thành phố ..."');
        return false;
    }

    if (remarkCheck.trim() !== '' && !englishWithNumbersAndSpecialCharsPattern.test(remarkCheck)) {
        return false;
    }

    if (!passwordPattern.test(checkPassword)) {
        alert('"Password must include uppercase,\n' +
            'lowercase and number."')
        return false;
    }

    if (!vietnameseWithoutDiacriticsPattern.test(inputFirstName) ||
        !vietnameseWithoutDiacriticsPattern.test(inputLastName)) {
        alert('Please do not enter accented Vietnamese FirstName or LastName!');
        return false;
    }

    if (!(vnPattern.test(inputPhone) || checkPhoneRegex.test(inputPhone))) {
        alert('Please enter in +84 format!');
        return false;
    }

    if (!emailPattern.test(inputEmail)) {
        alert('Please enter a valid email format in the Input Email box!');
        return false;
    }

    return true;
}

