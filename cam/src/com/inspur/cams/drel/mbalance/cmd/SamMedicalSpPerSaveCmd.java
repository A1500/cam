package com.inspur.cams.drel.mbalance.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.data.SamMedicalSpPer;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalSpPerDomain;
/***
 * 一站结算_优抚救助比例的插入和修改
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalSpPerSaveCmd extends BaseAjaxCommand {
	private ISamMedicalSpPerDomain samMedicalSpPerDomain=ScaComponentFactory.getService(ISamMedicalSpPerDomain.class, "samMedicalSpPerDomain/samMedicalSpPerDomain");
	public void execute(){
		
	}
	/**
	 * 优抚救助比例的插入
	 */
	public void insert(){
		SamMedicalSpPer samMedicalSpPer=(SamMedicalSpPer)getParameter("samMedicalSpPer");
		String id=samMedicalSpPerDomain.insert(samMedicalSpPer);
		setReturn("id", id);
	}
	/**
	 * 优抚救助比例的修改
	 */
	public void update(){
		SamMedicalSpPer samMedicalSpPer=(SamMedicalSpPer)getParameter("samMedicalSpPer");
		samMedicalSpPerDomain.update(samMedicalSpPer);
	}
	/**
	 * 获取当前登录单位的行政区划
	 */
	public void getOnLineInf(){
		String organCode=BspUtil.getCorpOrgan().getOrganCode();
		setReturn("organCode", organCode);
	}
	/**
	 * 批量设定时保存
	 */
	public void save(){
		Record[] records = (Record[]) getParameter("records");
		List<SamMedicalSpPer> list = new ArrayList<SamMedicalSpPer>();
		for (int i = 0; i < records.length; i++) {
			SamMedicalSpPer dataBean = (SamMedicalSpPer) records[i].toBean(SamMedicalSpPer.class);
			dataBean.setId(IdHelp.getUUID30());
			dataBean.setYear(Integer.parseInt(DateUtil.getYear())+1+"");
			list.add(dataBean);
		}
		samMedicalSpPerDomain.save(list);
	}
}
