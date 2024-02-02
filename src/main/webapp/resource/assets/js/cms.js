$(document).ready(function () {


    const modal = $('#modal');
    let isClick = false;
    const btnUpdate = $('#btn-update');
    let showUpdate = $('#show-update');
    let showDelete = $('#show-delete');
    const elementInputUp = $('#first_name-up, #birth-up, #phone-up, #last_name-up, #account-up, #email-up, #password-up, #department-up,#female-up,#male-up');

    $(document).on('click', '#open-drop-menu', function (e) {
        e.stopPropagation();

        if (isClick) {
            $('#drop-menu').hide().slideUp(350);
            $('.fa-solid.fa-chevron-down').hide();
            $('.fa-solid.fa-chevron-up').show();
        } else {
            $('#drop-menu').show().slideDown(400);
            $('.fa-solid.fa-chevron-down').show();
            $('.fa-solid.fa-chevron-up').hide();
        }

        isClick = !isClick;
    })


    $('.update-emp').on('click', function () {

        modal.show();
        showDelete.hide();
        showUpdate.show();

        let row = $(this).closest('tr');
        let getData = getTableRowData(row);

        let split = splitFullName(getData.fullName);

        let first_name = split.firstName;
        let last_name = split.lastName;
        let selector = $('#department-up');
        let statusValue = 1;
        let state = $('#status-up');

        // Add value in input
        state.prop('checked', statusValue === 1);

        if (getData.status === 0) {
            state.prop('checked', false);
        }

        if (getData.gender === "1") {
            $("#female-up").prop('checked', true);
        } else {
            $("#male-up").prop('checked', true);
        }


        if ($('#department option[value="' + getData.department + '"]').length === 0) {
            selector.append(new Option(getData.department, getData.department));
        }

        $('#number').val(getData.id);
        $('#number-account').val(getData.idAccount);
        $('#password-up').val(getData.password);
        $('#email-up').val(getData.email);
        $('#remark').val(getData.remark);
        $('#account-up').val(getData.account)
        $('#first_name-up').val(first_name);
        $('#last_name-up').val(last_name);
        $('#birth-up').val(getData.dateOfBirth);
        $('#address').val(getData.address);
        $('#phone-up').val(getData.phoneNumber);
        selector.val(getData.department);
    });


    $('.delete-emp').on('click', function () {

        modal.show();
        showUpdate.hide();
        showDelete.show();

        let row = $(this).closest('tr');
        let getData = getTableRowData(row);

        let split = splitFullName(getData.fullName);

        let first_name = split.firstName;
        let last_name = split.lastName;
        let selector = $('#department-dle');
        let statusValue = 1;
        let state = $('#status-dle');

        // Add value in input
        state.prop('checked', statusValue === 1);

        if (getData.status === 0) {
            state.prop('checked', false);
        }

        if (getData.gender === "1") {
            $("#female-dle").prop('checked', true);
        } else {
            $("#male-dle").prop('checked', true);
        }

        if ($('#department option[value="' + getData.department + '"]').length === 0) {
            selector.append(new Option(getData.department, getData.department));
        }

        $('#epm-delete').val(getData.id);
        $('#ac-delete').val(getData.idAccount);
        $('#remark-delete').val(getData.remark);
        $('#firstname').val(first_name);
        $('#lastname').val(last_name);
        $('#date').val(getData.dateOfBirth);
        $('#address-delete').val(getData.address);
        $('#phone-number').val(getData.phoneNumber);
        selector.val(getData.department);
        $('#password-dle').val(getData.password);
        $('#account-dle').val(getData.account)
        $('#email-dle').val(getData.email);


    });


    $('#close,.close').on('click', function () {
        modal.hide();
    });


    $('.close-notify#close-notify').on('click', function () {
        $('#notify').slideUp(500, function () {
            $(this).hide();
        });
    });

    let signal = $('#signal');
    let notify = $('#notify');

    // Tạo promise cho hiệu ứng giảm kích thước
    let scalePromise = new Promise(function (resolve) {
        setTimeout(function () {
            startScaleEffect();
            resolve();
        },);
    });


    let notifyPromise = new Promise(function (resolve) {
        setTimeout(function () {
            notify.slideUp(555, function () {
                $(this).hide();
                resolve();
            });
        }, 5000);
    });

    Promise.all([scalePromise, notifyPromise]).then(function () {
        signal.hide();
        notify.hide();
    });


// Validation for all fields on form submission
    btnUpdate.on('click', function (event) {
        if (elementInputUp.val() !== '') {
            if (!validateForm()) {
                event.preventDefault();
            }else {
                let isValid = true;

                elementInputUp.each(function () {
                    if ($(this).val().trim() === '') {
                        isValid = false;
                        return false;
                    }
                });

                let confirmResult = confirm('Do you want to delete Yes/No?');

                if (confirmResult) {
                    $('#form-update').submit();
                }
            }
        }
    });


    // Validation for individual form fields on blur event
    elementInputUp.on("blur input", function () {
        handleValidation($(this));
    });



    $(document).on('click', '#btn-delete', function () {

        let confirmResult = confirm('Do you want to delete Yes/No?');


        if (confirmResult) {
            $("#form-delete").submit();
        } else {
            modal.hide();
        }

    })


    $('#btn-search,#click-submit').on('click', function (event) {

        event.preventDefault();

        let search = $("#search").val();
        let filter = $("#filter-by").val();

        if (search.trim() === '') {
            handleValidator($('#search'))
        }

        if (filter.trim() === '') {
            handleValidator($('#filter-by'))
        }

        if (search.trim() !== '' && filter.trim() !== '') {
            $('#form-search').submit();
        }

    });

    $('li.disable,a.disable').on('click', function (event) {
        event.preventDefault();
        console.log("click none!!")
    });


});


function validateForm() {

    let regexCheckVietnamese = /^[a-zA-Z\s]+$/;
    let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    let vnPattern = /^(0[1-9]|84[1-9])[0-9]{3,}$/;
    let checkPhoneRegex = /^\+\d{1,4}[0-9]{6,}$/;
    let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$/;
    let englishWithNumbersAndSpecialCharsPattern = /^[a-zA-Z0-9!@#$%^&*+()]*$/;
    let addressFormatRegex = /^[a-zA-Z0-9@#$%^&+=!\s-]*$/;


    let inputEmail = $('#email-up').val();
    let inputPhone = $('#phone-up').val();
    let inputFirstName = $('#first_name-up').val();
    let inputLastName = $('#last_name-up').val();
    let inputAccount = $('#account-up').val();
    let addressCheck = $('#address').val();
    let remarkCheck = $('#remark').val();
    let checkPassword = $('#password-up').val();


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

    if (!regexCheckVietnamese.test(inputFirstName) ||
        !regexCheckVietnamese.test(inputLastName)) {
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


function startScaleEffect() {
    let content = $('#signal');

    let scaleValue = 1;
    let interval = setInterval(function () {
        if (scaleValue > 0) {
            content.css('transform', 'scale(' + scaleValue + ')');
            scaleValue -= 0.1;
        } else {
            clearInterval(interval);
        }
    }, 300);
}


function splitFullName(fullName) {

    let spaceIndex = fullName.indexOf(" ");


    if (spaceIndex === -1) {
        return {
            firstName: fullName.trim(),
            lastName: ''
        };
    }

    let firstName = fullName.substring(0, spaceIndex).trim();
    let lastName = fullName.substring(spaceIndex).trim();

    return {
        firstName: firstName,
        lastName: lastName
    };
}


function getTableRowData(row) {
    return {
        id: row.find('.number').text(),
        idAccount: row.find('.number-count').text(),
        fullName: row.find('.full-name').text(),
        dateOfBirth: row.find('.date-of-birth').text(),
        address: row.find('.address').text(),
        phoneNumber: row.find('.phone-number').text(),
        department: row.find('.department-table').text(),
        gender: row.find('.gender').text(),
        remark: row.find('.remark').text(),
        status: row.find('.status').text(),
        password: row.find('.password').text(),
        email: row.find('.email').text(),
        account: row.find('.account').text()
    };
}


function handleValidator(element) {
    let msg = element.next('.error-message');

    if (element.trim() === '') {
        msg.text('Please enter this field!').show();
    } else {
        msg.text('').show();
    }

}

