package com.inspur.cams.drel.mbalance.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.data.SamMedicalPer;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalPerDomain;
/***
 * 一站结算_救助比例的插入修改
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalPerSaveCmd extends BaseAjaxCommand {
	private ISamMedicalPerDomain samMedicalPerDomain=ScaComponentFactory.getService(ISamMedicalPerDomain.class, "samMedicalPerDomain/samMedicalPerDomain");
	public void execute(){
		
	}
	/**
	 * 救助比例的插入
	 */
	public void insert(){
		SamMedicalPer samMedicalPer=(SamMedicalPer)getParameter("samMedicalPer");
		String id=samMedicalPerDomain.insert(samMedicalPer);
		setReturn("id", id);
	}
	/**
	 * 救助比例的修改
	 */
	public void update(){
		SamMedicalPer samMedicalPer=(SamMedicalPer)getParameter("samMedicalPer");
		samMedicalPerDomain.update(samMedicalPer);
	}
	/**
	 * 获取当前登录单位的行政区划
	 */
	public void getOnLineInf(){
		String organCode=BspUtil.getCorpOrgan().getOrganCode();
		setReturn("organCode", organCode);
	}
	/**
	 * 救助比例批量保存
	 */
	public void save(){
		Record[] records = (Record[]) getParameter("records");
		List<SamMedicalPer> list = new ArrayList<SamMedicalPer>();
		for (int i = 0; i < records.length; i++) {
			SamMedicalPer dataBean = (SamMedicalPer) records[i].toBean(SamMedicalPer.class);
			dataBean.setId(IdHelp.getUUID30());
			dataBean.setYear(Integer.parseInt(DateUtil.getYear())+1+"");
			list.add(dataBean);
		}
		samMedicalPerDomain.save(list);
	}
}
