package com.inspur.cams.comm.brief.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.brief.data.CamsReportWork;
import com.inspur.cams.comm.brief.domain.ICamsReportWorkDomain;

/**
 * 填报期数配置表command
 * @author 
 * @date 2014-04-23
 */
public class CamsReportWorkCommand extends BaseAjaxCommand {

	private ICamsReportWorkDomain camsReportWorkDomain = ScaComponentFactory
			.getService(ICamsReportWorkDomain.class, "camsReportWorkDomain/camsReportWorkDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CamsReportWork camsReportWork = (CamsReportWork) record.toBean(CamsReportWork.class);
		camsReportWorkDomain.insert(camsReportWork);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CamsReportWork camsReportWork = (CamsReportWork) record.toBean(CamsReportWork.class);
		camsReportWorkDomain.update(camsReportWork);
	}
	
	// 删除
	public void delete() {
		String workId = (String) getParameter("workId");
		camsReportWorkDomain.delete(workId);
	}
	
	// 开启上报任务
	public void unlock() {
		String workId= (String) getParameter("workId");
		camsReportWorkDomain.unlock(workId);
	}
	// 关闭上报任务
	public void lock() {
		String workId= (String) getParameter("workId");
		camsReportWorkDomain.lock(workId);
	}
	
	//查询本批次是否已录该区划
		public void ifRepeated() {
			String workId = (String) getParameter("workId");
			ParameterSet pset = new ParameterSet();
			pset.setParameter("WORK_ID@=",workId);
			DataSet ds = camsReportWorkDomain.query(pset);
			if(ds.getCount()>0){
				this.setReturn("ifRepeatTips","该期数已经录入改区划，不可重复录入!");
			}
		}
}