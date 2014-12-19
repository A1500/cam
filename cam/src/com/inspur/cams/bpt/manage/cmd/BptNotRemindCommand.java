package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptNotRemindDao;
import com.inspur.cams.bpt.base.data.BptNotRemind;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
/**
 * @title:BptNotRemindCommand
 * @description:
 * @author:
 * @since:2014-05-09
 * @version:1.0
*/
public class BptNotRemindCommand extends BaseAjaxCommand{
	private BptNotRemindDao dao = (BptNotRemindDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptNotRemindDao");

	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptNotRemind dataBean=(BptNotRemind)record.toBean(BptNotRemind.class);
		dao.insert(dataBean);
	}
	@Trans
	public void insertRemind() {
		String applyId = (String) getParameter("applyId");
		String peopleId = (String) getParameter("peopleId");
		String remindType = (String) getParameter("remindType");
		String userId=GetBspInfo.getBspInfo().getUserId();
		BptNotRemind dataBean=new BptNotRemind();
		dataBean.setId(IdHelp.getUUID32());
		dataBean.setApplyId(applyId);
		dataBean.setPeopleId(peopleId);
		dataBean.setRemindDate(DateUtil.getDay());
		dataBean.setRemindType(remindType);
		dataBean.setUserId(userId);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptNotRemind dataBean=(BptNotRemind)record.toBean(BptNotRemind.class);
		dao.update(dataBean);
	}

	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void deleteRemindByAppplyUserId() {
		String applyId = (String) getParameter("applyId");
		dao.deleteRemindByAppplyUserId(applyId);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptNotRemind> list = new ArrayList<BptNotRemind>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptNotRemind dataBean = (BptNotRemind) records[i].toBean(BptNotRemind.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	/**
	 * 查询待办任务数量及认证人数
	 * 
	 * @param pset
	 * @return
	 */
	public Map<String,String>  queryDaiBanRemindNum (){
		 Map map =dao.queryDaiBanRemindNum();
		 //this.setReturn("rz", map.get("rz"));
		return map;
		
	}
	/**
	 * 取消双重身份提醒
	 * 
	 */
	public void insertRemindDP(){
		String peopleId = (String) getParameter("peopleId");
		dao.insertRemindDP(peopleId);
	}
	
	/**
	 * 修改人员状态后判断是否添加到提醒表(是否不再提醒)
	 * 
	 */
	public void changeRemindDP(){
		String peopleId = (String) getParameter("peopleId");
		dao.changeRemindDP(peopleId);
	}
	/**
	 * 查询修改状态后此人是否还是双重身份
	 * 
	 */
	public void queryIsDP(){
		String peopleId = (String) getParameter("peopleId");
		DataSet ds =dao.queryIsDP(peopleId);
		this.setReturn("num", ds.getCount());
	}
}
