package com.inspur.cams.dis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.dao.support.DisReliefInfoDao;
import com.inspur.cams.dis.base.data.DisReliefInfo;
import com.inspur.cams.dis.base.domain.IDisReliefInfoDomain;
/**
 * @title:DisReliefInfoCommand
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
public class DisReliefInfoCommand extends BaseAjaxCommand{
	private DisReliefInfoDao dao = (DisReliefInfoDao) DaoFactory
			.getDao("com.inspur.cams.dis.base.dao.support.DisReliefInfoDao");
	private IDisReliefInfoDomain service = ScaComponentFactory.getService(IDisReliefInfoDomain.class,"disReliefInfoDomain/disReliefInfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		DisReliefInfo dataBean=(DisReliefInfo)record.toBean(DisReliefInfo.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record infoRecord = (Record) getParameter("infoRecord");
		DisReliefInfo info = new DisReliefInfo();
		info=(DisReliefInfo)infoRecord.toBean(DisReliefInfo.class);
		service.saveInfo(info);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		String batchDetailId = (String) getParameter("batchDetailId");
		boolean bl = true;
		for(String delId : delIds) {
			bl = service.checkDelete(delId);
			if(!bl) {
				break;
			}
		}
		if(!bl) {
			this.setReturn("result", "删除失败，记录已经提交不能删除！");
		} else {
			service.batchDelete(delIds, batchDetailId);
		}
	}
	public void save() {
		Record infoRecord = (Record) this.getParameter("infoRecord");
		
		DisReliefInfo info = (DisReliefInfo) infoRecord.toBean(DisReliefInfo.class);
		
		
		service.saveInfo(info);
	}
	
	/**
	 * 批量提交
	 */
	public void batchSubmit() {
		String[] subIds = (String[]) getParameter("subIds");
		if(subIds != null && subIds.length != 0) {
			service.batchSubmit(subIds);
		}
	}
	
	/**
	 * 查询是否可以删除
	 */
	public void checkDelete() {
		String infoId = (String) getParameter("infoId");
		boolean bl = service.checkDelete(infoId);
		this.setReturn("result", bl);
	}
	
	public void checkUpdate() {
		String infoId = (String) getParameter("infoId");
		boolean bl = service.checkUpdate(infoId);
		this.setReturn("result", bl);
	}
}
