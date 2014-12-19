package com.inspur.sdmz.jzzs.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.core.BusinessException;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.sdmz.jzzs.dao.jdbc.YgjzJzzsConfDao;
import com.inspur.sdmz.jzzs.data.YgjzJzzsConf;

/**
 * @title:YgjzJzzsConfCommand
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
*/
public class YgjzJzzsConfCommand extends BaseAjaxCommand{
	private YgjzJzzsConfDao dao = (YgjzJzzsConfDao) DaoFactory
			.getDao("com.inspur.sdmz.jzzs.dao.jdbc.YgjzJzzsConfDao");
	/**
	 * 保存修改
	 */
	public void execute() {
		YgjzJzzsConfDao dao = (YgjzJzzsConfDao) DaoFactory.getDao(YgjzJzzsConfDao.class);
		// 获取界面传过来的参数：被修改的Record数组
		Record[] records = (Record[]) getParameter("records");
		ParameterSet pset = new ParameterSet();
		String str= "";
		for (int i = 0; i < records.length; i++) {
			// 将Record转换为相应的bean:Cust
			YgjzJzzsConf ygjzJzzsConf = (YgjzJzzsConf) records[i].toBean(YgjzJzzsConf.class);
			pset.setParameter("HELP_ORGAN_REGION@=", ygjzJzzsConf.getHelpOrganRegion());
			DataSet ds=dao.query(pset);
			if((records[i].getState()==Record.STATE_NEW && ds.getCount()>0)||
					(records[i].getState()==Record.STATE_MODIFIED && ds.getCount()>1)){
				str=str+ygjzJzzsConf.getHelpOrganRegion()+";" ;
			}else{
				switch(records[i].getState()){
				case Record.STATE_NEW:
					dao.insert(ygjzJzzsConf);
					break;
				case Record.STATE_MODIFIED:
					dao.update(ygjzJzzsConf);
					break;
				case Record.STATE_DELETED:
					dao.delete(ygjzJzzsConf.getHelpOrganRegion());
					break;
				default:
					break;
				}
			}
			pset.clear();
			if(!"".equals(str))
				throw new BusinessException("编号："+str+"不能重复！");
		}
		// 调用服务,执行保存

	}
	
	public void insert() {
		Record record = (Record) getParameter("record");
		YgjzJzzsConf dataBean=(YgjzJzzsConf)record.toBean(YgjzJzzsConf.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		YgjzJzzsConf dataBean=(YgjzJzzsConf)record.toBean(YgjzJzzsConf.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void remove(){
		YgjzJzzsConfDao dao = (YgjzJzzsConfDao) DaoFactory.getDao(YgjzJzzsConfDao.class);
		Record[] records = (Record[])getParameter("records");
		for(int i = 0; i < records.length; i++){
			YgjzJzzsConf ygjzJzzsConf = (YgjzJzzsConf)records[i].toBean(YgjzJzzsConf.class);
			dao.delete(ygjzJzzsConf.getHelpOrganRegion());
		}
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<YgjzJzzsConf> list = new ArrayList<YgjzJzzsConf>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			YgjzJzzsConf dataBean = (YgjzJzzsConf) records[i].toBean(YgjzJzzsConf.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
