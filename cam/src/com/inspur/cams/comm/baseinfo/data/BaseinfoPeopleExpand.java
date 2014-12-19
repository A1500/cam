package com.inspur.cams.comm.baseinfo.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

	@Table(tableName = "BASEINFO_PEOPLE_EXTEND" , keyFields = "peopleId")
	public class BaseinfoPeopleExpand extends StatefulDatabean {	
		  //人员ID
	   	@Rule(value="require|length{32}")
		@Column(name = "PEOPLE_ID")
	   private String peopleId;
		  //是否上学
		@Column(name = "STUDENT_FLAG")
	   private String isStudy;
		  //人员ID
		@Column(name = "WORKABILITY_CODE")
	   private String isWork;
		public String getPeopleId() {
			return peopleId;
		}
		public void setPeopleId(String peopleId) {
			this.peopleId = peopleId;
		}
		public String getIsStudy() {
			return isStudy;
		}
		public void setIsStudy(String isStudy) {
			this.isStudy = isStudy;
		}
		public String getIsWork() {
			return isWork;
		}
		public void setIsWork(String isWork) {
			this.isWork = isWork;
		}
		
}
