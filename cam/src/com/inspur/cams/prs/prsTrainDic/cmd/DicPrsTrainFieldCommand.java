package com.inspur.cams.prs.prsTrainDic.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.prs.prsTrainDic.dao.DicPrsTrainField;
import com.inspur.cams.prs.prsTrainDic.dao.DicPrsTrainFieldDao;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:DicPrsTrainFieldCommand
 * @description:
 * @author:
 * @since:2012-09-21
 * @version:1.0
*/
public class DicPrsTrainFieldCommand extends BaseAjaxCommand{
	private DicPrsTrainFieldDao dao = (DicPrsTrainFieldDao) DaoFactory
			.getDao("com.inspur.cams.prs.prsTrainDic.dao.DicPrsTrainFieldDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		DicPrsTrainField dataBean=(DicPrsTrainField)record.toBean(DicPrsTrainField.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		DicPrsTrainField dataBean=(DicPrsTrainField)record.toBean(DicPrsTrainField.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		Record[] records = (Record[]) getParameter("records");
		for (int i = 0; i < records.length; i++) {
			DicPrsTrainField dataBean = (DicPrsTrainField) records[i].toBean(DicPrsTrainField.class);
			if (dataBean.getState()==Record.STATE_DELETED){
				dao.delete(dataBean);
			}else if(dataBean.getState() == Record.STATE_MODIFIED){
				dao.update(dataBean);
			}else if(dataBean.getState()==Record.STATE_NEW){
				dataBean.setCode(IdHelp.getUUID32());
				dao.insert(dataBean);
			}
		}
	}
}
