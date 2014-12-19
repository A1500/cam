package com.inspur.cams.bpt.base.data;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * BptYearPhoto
 * @description: 优抚对象年度照片
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 @Table(tableName = "BPT_YEAR_PHOTO" , keyFields = "PHOTO_ID")
public class BptYearPhoto extends StatefulDatabean {
   //人员id
	@Column(name = "PEOPLE_ID")
   private String peopleId;
   //照片id
	@Column(name = "PHOTO_ID")
   private String photoId;
	
	//照片id
	@Column(name = "year")
	private String year;
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getPeopleId() {
		return peopleId;
	}
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	public String getPhotoId() {
		return photoId;
	}
	public void setPhotoId(String photoId) {
		this.photoId = photoId;
	}
   

}