package dto;


import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeDto {

    private Integer id;
    private String firstName;
    private String lastName;
    private Integer gender;
    private LocalDate date;
    private String phone;
    private String address;
    private String  department;
    private String remark;

    public EmployeeDto(String firstName, String lastName, Integer gender, LocalDate date, String phone, String address, String department, String remark) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.date = date;
        this.phone = phone;
        this.address = address;
        this.department = department;
        this.remark = remark;
    }
}
