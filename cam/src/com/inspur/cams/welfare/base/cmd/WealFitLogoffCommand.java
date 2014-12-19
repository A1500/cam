package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.welfare.base.dao.support.WealFitLogoffDao;
import com.inspur.cams.welfare.base.data.WealFitLogoff;
import com.inspur.cams.welfare.base.domain.IWealFitLogoffDomain;

/**
 * @title:WealFitLogoffCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealFitLogoffCommand extends BaseAjaxCommand{
	private WealFitLogoffDao dao = (WealFitLogoffDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealFitLogoffDao");
	
	private IWealFitLogoffDomain wealFitLogoffDomain = ScaComponentFactory
	.getService(IWealFitLogoffDomain.class, "wealFitLogoffDomain/wealFitLogoffDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealFitLogoff dataBean=(WealFitLogoff)record.toBean(WealFitLogoff.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealFitLogoff dataBean=(WealFitLogoff)record.toBean(WealFitLogoff.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealFitLogoff> list = new ArrayList<WealFitLogoff>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealFitLogoff dataBean = (WealFitLogoff) records[i].toBean(WealFitLogoff.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	//假肢企业注销备案信息表保存同时更新业务表.
	public void saveCancel(){
		Record record = (Record) getParameter("record");
		wealFitLogoffDomain.saveCancel(record);
		
	}
	//福利企业注销备案信息表保存同时更新业务表.
	public void welfarecorpSaveCancel(){
		Record record = (Record) getParameter("record");
		wealFitLogoffDomain.welfarecorpSaveCancel(record);
		
	}
	//假肢企业注销
	public void prosthesisCancel(){
		Record record = (Record) getParameter("record");
		wealFitLogoffDomain.prosthesisCancel(record);
	}
	
	//福利企业注销
	public void wealfarecorpCancel(){
		Record record = (Record) getParameter("record");
		wealFitLogoffDomain.wealfarecorpCancel(record);
	}
}
