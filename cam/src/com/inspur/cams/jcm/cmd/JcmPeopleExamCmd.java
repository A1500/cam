package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmPeopleExam;
import com.inspur.cams.jcm.domain.IJcmPeopleExamDomain;

/**
 * 人员培训信息（多条记录过程）cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleExamCmd extends BaseAjaxCommand {

	private IJcmPeopleExamDomain jcmPeopleExamDomain = ScaComponentFactory
			.getService(IJcmPeopleExamDomain.class, "jcmPeopleExamDomain/jcmPeopleExamDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmPeopleExam jcmPeopleExam = (JcmPeopleExam) record.toBean(JcmPeopleExam.class);
		jcmPeopleExamDomain.insert(jcmPeopleExam);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmPeopleExam jcmPeopleExam = (JcmPeopleExam) record.toBean(JcmPeopleExam.class);
		jcmPeopleExamDomain.update(jcmPeopleExam);
	}
	
	// 删除
	public void delete() {
		String peopleExamId = (String) getParameter("peopleExamId");
		jcmPeopleExamDomain.delete(peopleExamId);
	}
	
}