const validateFrom = $('#username, #password');
const msg = $('.error-message');

$(document).ready(function () {

    validateFrom.on("blur input", function () {
        handleValidation($(this), msg);
    });

    validateFrom.on("keypress", function (event) {
        if (event.which === 13) {
            event.preventDefault();
            handleFormSubmission();
        }
    });

    $('#login-user').on('click', function (event) {
        event.preventDefault();
        handleFormSubmission();

    });

});

function handleFormSubmission() {
    let username = $('#username').val();
    let password = $("#password").val();

    // Reset styles for all input fields
    validateFrom.css("border", "1px solid #155FEE");
    msg.text('');

    if (username.trim() === '') {
        $("#username").css("border", "1px solid red");
        msg.text('Please enter this field!').show();
    }

    if (password.trim() === '') {
        $('#password').css("border", "1px solid red");
        msg.text('Please enter this field!').show();
    }

    if (username.trim() !== '' && password.trim() !== '') {
        $('#login-form').submit();
    }

}


function handleValidation(element, errorMessageElement) {
    let targetField = element.attr('id');
    if (element.val().trim() === '') {
        showError(element, errorMessageElement.filter(`[data-target=${targetField}]`), 'Please enter this field!');
    } else {
        hideError(element, errorMessageElement.filter(`[data-target=${targetField}]`));
    }
}

function showError(element, errorMessageElement, message) {
    element.css("border", "1px solid red");
    errorMessageElement.text(message).show();
}

function hideError(element, errorMessageElement) {
    element.css("border", "1px solid #155FEE");
    errorMessageElement.text('');
}
