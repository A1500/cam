package com.inspur.cams.drel.mbalance.cmd;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.drel.mbalance.data.SamMedicalTopLine;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalTopLineDomain;
/***
 * 一站结算_救助封顶线的插入和修改
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalTopLineSaveCmd  extends BaseAjaxCommand{
	private ISamMedicalTopLineDomain samMedicalTopLineDomain=ScaComponentFactory.getService(ISamMedicalTopLineDomain.class, "samMedicalTopLineDomain/samMedicalTopLineDomain");
	public void execute(){
		
	}
	/**
	 * 救助封顶线的插入
	 */
	public void insert(){
		SamMedicalTopLine samMedicalTopLine=(SamMedicalTopLine)getParameter("samMedicalTopLine");
		String id=samMedicalTopLineDomain.insert(samMedicalTopLine);
		setReturn("id", id);
	}
	/**
	 * 救助封顶线的修改
	 */
	public void update(){
		SamMedicalTopLine samMedicalTopLine=(SamMedicalTopLine)getParameter("samMedicalTopLine");
		samMedicalTopLineDomain.update(samMedicalTopLine);
	}
	/**
	 * 获取当前登录单位的行政区划
	 */
	public void getOnLineInf(){
		String organCode=BspUtil.getCorpOrgan().getOrganCode();
		setReturn("organCode", organCode);
	}
}
