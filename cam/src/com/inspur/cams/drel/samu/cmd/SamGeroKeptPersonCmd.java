package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.data.SamGeroKeptPerson;
import com.inspur.cams.drel.samu.domain.ISamGeroKeptPersonDomain;

/**
 * 供养对象信息表cmd
 * @author 
 * @date 2012-10-24
 */
public class SamGeroKeptPersonCmd extends BaseAjaxCommand {

	private ISamGeroKeptPersonDomain samGeroKeptPersonDomain = ScaComponentFactory
			.getService(ISamGeroKeptPersonDomain.class, "samGeroKeptPersonDomain/samGeroKeptPersonDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamGeroKeptPerson samGeroKeptPerson = (SamGeroKeptPerson) record.toBean(SamGeroKeptPerson.class);
		samGeroKeptPersonDomain.insert(samGeroKeptPerson);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamGeroKeptPerson samGeroKeptPerson = (SamGeroKeptPerson) record.toBean(SamGeroKeptPerson.class);
		samGeroKeptPersonDomain.update(samGeroKeptPerson);
	}
	
	// 删除
	public void delete() {
		String personId = (String) getParameter("personId");
		samGeroKeptPersonDomain.delete(personId);
	}
	public void insertAll(){
		Record[] recordPeople = (Record[]) getParameter("recordPeople");
		Record[] recordPerson = (Record[]) getParameter("recordPerson");
		Record[] recordApply = (Record[]) getParameter("recordApply");
		samGeroKeptPersonDomain.insertAll(recordPerson,recordApply,recordPeople);
	}
	public void outGero(){
		Record recordApply = (Record) getParameter("recordApply");
		Record recordPerson = (Record) getParameter("recordPerson");
		samGeroKeptPersonDomain.outGero(recordPerson,recordApply);
	}
}