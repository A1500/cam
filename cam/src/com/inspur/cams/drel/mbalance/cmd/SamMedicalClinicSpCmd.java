package com.inspur.cams.drel.mbalance.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.mbalance.data.SamMedicalClinicSp;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalClinicSpDomain;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-7-20
 */
public class SamMedicalClinicSpCmd extends BaseAjaxCommand{
	private ISamMedicalClinicSpDomain service=ScaComponentFactory.getService(ISamMedicalClinicSpDomain.class,"samMedicalClinicSpDomain/samMedicalClinicSpDomain");
	
	public void insert(){
		Record record=(Record)getParameter("medicalClinic");
		SamMedicalClinicSp bean=(SamMedicalClinicSp)record.toBean(SamMedicalClinicSp.class);
		service.insert(bean);		
	}
	
	public void update(){
		Record record=(Record)getParameter("medicalClinic");
		SamMedicalClinicSp bean=(SamMedicalClinicSp)record.toBean(SamMedicalClinicSp.class);
		service.update(bean);
	}
	
	public void delete(){		
		String[] ids=(String[])getParameter("ids");
		service.delete(ids);
	}
	
	public void submitRule(){
		String[] ids=(String[])getParameter("ids");
		service.submitRule(ids);
		
	}
}
