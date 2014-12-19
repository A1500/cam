package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptPetitionDao;
import com.inspur.cams.bpt.base.data.BptPetition;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptPetitionCommand
 * @description:
 * @author:
 * @since:2011-05-25
 * @version:1.0
*/
public class BptPetitionCommand extends BaseAjaxCommand{
	private BptPetitionDao dao = (BptPetitionDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPetitionDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptPetition dataBean=(BptPetition)record.toBean(BptPetition.class);
		dataBean.setPetitionId(IdHelp.getUUID30());
		dataBean.setRegId(BspUtil.getEmpOrganId());
		dataBean.setRegTime(DateUtil.getTime());
		dataBean.setModId(BspUtil.getEmpOrganId());
		dataBean.setModTime(DateUtil.getTime());
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record[] record = (Record[]) getParameter("record");
		for (Record r : record) {
			BptPetition dataBean=(BptPetition)r.toBean(BptPetition.class);
			dao.update(dataBean);
		}
	}
	@Trans
	public void upload(){
		Record record = (Record) getParameter("uploadRd"); 
		BptPetition dataBean=(BptPetition)record.toBean(BptPetition.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			String edocumentsName =uploadfile.getFileName();
			dataBean.setEdocumentsName(edocumentsName);
			dataBean.setEdocuments(uploadfile);
			dao.updateWithFile(dataBean);
		}
		
		
	} 
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptPetition> list = new ArrayList<BptPetition>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptPetition dataBean = (BptPetition) records[i].toBean(BptPetition.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
