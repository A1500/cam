package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmPeopleResume;
import com.inspur.cams.jcm.domain.IJcmPeopleResumeDomain;

/**
 * 人员简历信息(多条记录)cmd
 * @author 
 * @date 2014-05-19
 */
public class JcmPeopleResumeCmd extends BaseAjaxCommand {

	private IJcmPeopleResumeDomain jcmPeopleResumeDomain = ScaComponentFactory
			.getService(IJcmPeopleResumeDomain.class, "jcmPeopleResumeDomain/jcmPeopleResumeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmPeopleResume jcmPeopleResume = (JcmPeopleResume) record.toBean(JcmPeopleResume.class);
		jcmPeopleResumeDomain.insert(jcmPeopleResume);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmPeopleResume jcmPeopleResume = (JcmPeopleResume) record.toBean(JcmPeopleResume.class);
		jcmPeopleResumeDomain.update(jcmPeopleResume);
	}
	
	// 删除
	public void delete() {
		String resumeId = (String) getParameter("resumeId");
		jcmPeopleResumeDomain.delete(resumeId);
	}
	
}