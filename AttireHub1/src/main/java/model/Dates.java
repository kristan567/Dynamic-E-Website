package model;
import java.util.Date;
import java.util.Calendar;


public class Dates {
	private int dateCode;
	private Date date;
	private int year;
	private int month;
	private int day;
	private int yearlyQuarter;
	

	public Dates(int date_code) {
		this.dateCode = date_code;
		this.date =  new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		this.year = calendar.get(Calendar.YEAR);
		this.month = calendar.get(Calendar.MONTH);
		this.day = calendar.get(Calendar.DAY_OF_MONTH);
		this.yearlyQuarter = (this.month / 3) + 1;
	}

	public int getDateCode() {
		return dateCode;
	}

	public void setDateCode(int date_code) {
		this.dateCode = date_code;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getYearlyQuarter() {
		return yearlyQuarter;
	}

	public void setYearlyQuarter(int yearly_quarter) {
		this.yearlyQuarter = yearly_quarter;
	}
}
