package com.inspur.cams.drel.mbalance.cmd;


import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.dao.jdbc.SamMedicalBeforeDao;
import com.inspur.cams.drel.mbalance.data.SamMBalance;
import com.inspur.cams.drel.mbalance.data.SamMedicalBefore;
import com.inspur.cams.drel.mbalance.domain.ISamMBalanceDomain;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalDetailExpenseDomain;

/**
 * @title:SamMedicalBalanceCommand
 * @description:一站式救助Command
 * @author:luguosui
 * @since:2011-05-13
 * @version:1.0
*/
public class SamMBalanceCmd extends BaseAjaxCommand{
	private ISamMBalanceDomain samMBalanceDomain=ScaComponentFactory.getService(ISamMBalanceDomain.class, "SamMBalanceDomain/SamMBalanceDomain");
	/**
	 * 插入一条一站式结算记录
	 */
	public void insert() {
		Record record = (Record) getParameter("records");
		SamMBalance dataBean=(SamMBalance)record.toBean(SamMBalance.class);
		dataBean.setRegTime(DateUtil.getTime());
		samMBalanceDomain.insert(dataBean);
	}
	/**
	 * 更新一站式救助信息
	 */
	public void update() {
		Record record = (Record) getParameter("records");
		SamMBalance dataBean=(SamMBalance)record.toBean(SamMBalance.class);
		dataBean.setModTime(DateUtil.getTime());
		samMBalanceDomain.update(dataBean);
	}
	/**
	 * 删除一站式救助信息
	 */
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		samMBalanceDomain.batchDelete(delIds);
	}
	/**
	 * 保存一站式救助信息
	 */
	public void save() {
		Record record = (Record) getParameter("records");
		Record beforeRecord = (Record) getParameter("beforeRecord");
		String needConnect = String.valueOf(getParameter("needConnect"));
		List<SamMBalance> list = new ArrayList<SamMBalance>();
		SamMBalance samMBalance = (SamMBalance) record.toBean(SamMBalance.class);
		list.add(samMBalance);
		SamMedicalBefore samMedicalBefore=null;
		if(beforeRecord!=null){
			samMedicalBefore = (SamMedicalBefore)beforeRecord.toBean(SamMedicalBefore.class);
			samMedicalBefore.setStatus("0");
		}
		samMBalanceDomain.save(list,samMedicalBefore,needConnect);
	}
	
	public void reg() {
		Record record = (Record) getParameter("records");
		Record beforeRecord = (Record) getParameter("beforeRecord");
		List<SamMBalance> list = new ArrayList<SamMBalance>();
		SamMBalance samMBalance = (SamMBalance) record.toBean(SamMBalance.class);
		samMBalance.setRegTime(DateUtil.getTime());
		samMBalance.setBalanceTime(DateUtil.getDay());
		samMBalance.setBalanceId(IdHelp.getUUID32());
		list.add(samMBalance);
		SamMedicalBefore samMedicalBefore=null;
		if(beforeRecord!=null){
			samMedicalBefore = (SamMedicalBefore)beforeRecord.toBean(SamMedicalBefore.class);
			samMedicalBefore.setStatus("0");
		}
		samMBalanceDomain.reg(list,samMedicalBefore);
	}
	/**
	 * 冲账信息保存
	 */
	public void saveStrike(){
		Record strikeRecord = (Record) getParameter("strikeRecord");
		SamMBalance strikeDataBean=(SamMBalance)strikeRecord.toBean(SamMBalance.class);
		//正确记录
		Record record = (Record) getParameter("records");
		SamMBalance dataBean=(SamMBalance)record.toBean(SamMBalance.class);
		dataBean.setRegTime(DateUtil.getTime());
		dataBean.setBalanceId(IdHelp.getUUID32());
		samMBalanceDomain.saveStrike(strikeDataBean,dataBean);
	}
	/**
	 * 停助方法
	 */
	public void stopAssistance(){
		ParameterSet parameterSet=getParameterSet();
		samMBalanceDomain.stopAssistant(parameterSet);
	}
	/**
	 * 校验唯一住院号
	 * 
	 */
	public void checkOnlyRecordId(){
		String hospitalRecordId = (String)getParameter("hospitalRecordId");
		String hospitalId = (String)getParameter("hospitalId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("hospital_Record_Id@=",hospitalRecordId);
		pset.setParameter("hospital_Id@=",hospitalId);
		DataSet ds = samMBalanceDomain.query(pset);
		if(ds.getCount() == 0){
			setReturn("flag", "true");
		}else{
			setReturn("flag", "false");
		}
		
	}
}
