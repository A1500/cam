package com.inspur.cams.dis.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.PubUtils;
import com.inspur.cams.dis.base.dao.support.DisReliefInfoDao;
import com.inspur.cams.dis.base.data.DisReliefInfo;
import com.inspur.cams.dis.base.domain.IDisReliefBatchDetailDomain;
import com.inspur.cams.dis.base.domain.IDisReliefInfoDomain;
/**
 * @title:DisReliefInfoCommand
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
public class DisReliefBatchDetailCommand extends BaseAjaxCommand{
	private DisReliefInfoDao dao = (DisReliefInfoDao) DaoFactory
			.getDao("com.inspur.cams.dis.base.dao.support.DisReliefInfoDao");
	private IDisReliefInfoDomain service = ScaComponentFactory.getService(IDisReliefInfoDomain.class,"disReliefInfoDomain/disReliefInfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		DisReliefInfo dataBean=(DisReliefInfo)record.toBean(DisReliefInfo.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		DisReliefInfo dataBean=(DisReliefInfo)record.toBean(DisReliefInfo.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<DisReliefInfo> list = new ArrayList<DisReliefInfo>();
//		for (int i = 0; i < records.length; i++) {
//			// convert record to entity bean
//			DisReliefInfo dataBean = (DisReliefInfo) records[i].toBean(DisReliefInfo.class);
//			list.add(dataBean);
//		}
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			DisReliefInfo dataBean = (DisReliefInfo) records[i].toBean(DisReliefInfo.class);
			service.save(dataBean);
		}

//		dao.save(list);
	}
	
	/**
	 * 批量提交
	 */
	public void batchSubmit() {
		IDisReliefBatchDetailDomain service = ScaComponentFactory.getService(IDisReliefBatchDetailDomain.class,
				"disReliefBatchDetailDomain/disReliefBatchDetailDomain");
		String subId = (String) getParameter("subId");
		if(!PubUtils.isEmpty(subId)) {
			String msg = service.batchSubmit(subId);
			this.setReturn("result", msg);
		}
	}
	
	
}
