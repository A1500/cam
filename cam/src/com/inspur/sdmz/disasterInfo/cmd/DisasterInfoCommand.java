package com.inspur.sdmz.disasterInfo.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.sdmz.comm.util.DateUtil;
import com.inspur.sdmz.disasterInfo.dao.DisasterInfo;
import com.inspur.sdmz.disasterInfo.dao.DisasterInfoDao;

/**
 * @title:DisasterInfoCommand
 * @description:
 * @author:
 * @since:2011-09-13
 * @version:1.0
*/
public class DisasterInfoCommand extends BaseAjaxCommand{
	private DisasterInfoDao dao = (DisasterInfoDao) DaoFactory.getDao("com.inspur.sdmz.disasterInfo.dao.DisasterInfoDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		DisasterInfo dataBean=(DisasterInfo)record.toBean(DisasterInfo.class);
		dataBean.setRegPeopleId(BspUtil.getEmpOrganId());//上报人ID
		dataBean.setRegOrganId(BspUtil.getCorpOrganId());//上报单位ID
		dataBean.setRegOrganArea(BspUtil.getCorpOrgan().getOrganCode());//上报单位区划
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		DisasterInfo dataBean=(DisasterInfo)record.toBean(DisasterInfo.class);
		dataBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		dataBean.setModPeopleId(BspUtil.getEmpOrganId());
		dataBean.setModOrgan(BspUtil.getCorpOrgan().getOrganName());
		dataBean.setModOrganId(BspUtil.getCorpOrganId());
		dataBean.setModOrganArea(BspUtil.getCorpOrgan().getOrganCode());
		dataBean.setModTime(DateUtil.getNewTime());
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	/**
	 * 2011-09-13
	 * 灾情上报操作
	 * 增加和修改统一方法
	 */
	public void save() {
		Record[] records = (Record[]) getParameter("records");
		String method=(String) getParameter("method");
		List<DisasterInfo> list = new ArrayList<DisasterInfo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			DisasterInfo dataBean = (DisasterInfo) records[i].toBean(DisasterInfo.class);
			if(method.equals("INSERT")){
				dataBean.setRegPeopleId(BspUtil.getEmpOrganId());//上报人ID
				dataBean.setRegOrganId(BspUtil.getCorpOrganId());//上报单位ID
				dataBean.setRegOrganArea(BspUtil.getCorpOrgan().getOrganCode());//上报单位区划
			}else if(method.equals("UPDATE")){
				dataBean.setModPeople(BspUtil.getEmpOrgan().getOrganName());
				dataBean.setModPeopleId(BspUtil.getEmpOrganId());
				dataBean.setModOrgan(BspUtil.getCorpOrgan().getOrganName());
				dataBean.setModOrganId(BspUtil.getCorpOrganId());
				dataBean.setModOrganArea(BspUtil.getCorpOrgan().getOrganCode());
				dataBean.setModTime(DateUtil.getNewTime());
			}
			list.add(dataBean);
		}
		dao.save(list);
	}
}
