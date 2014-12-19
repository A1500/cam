package com.inspur.cams.comm.diccityChange.cmd;

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
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccityChange.dao.IDicCityChangeBatchAttachDao;
import com.inspur.cams.comm.diccityChange.dao.jdbc.DicCityChangeBatchAttachDao;
import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch;
import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatchAttach;
import com.inspur.cams.comm.diccityChange.domain.IDicCityChangeBatchAttachDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.comm.util.IdHelp;

/**
 * 区划变更上传附件表cmd
 * @author 
 * @date 2014-01-13
 */
public class DicCityChangeBatchAttachCmd extends BaseAjaxCommand {

	private IDicCityChangeBatchAttachDomain dicCityChangeBatchAttachDomain = ScaComponentFactory
			.getService(IDicCityChangeBatchAttachDomain.class, "dicCityChangeBatchAttachDomain/dicCityChangeBatchAttachDomain");
	
	private IDicCityChangeBatchAttachDao attachmentDao = (DicCityChangeBatchAttachDao) DaoFactory
		.getDao("com.inspur.cams.comm.diccityChange.dao.jdbc.DicCityChangeBatchAttachDao");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicCityChangeBatchAttach dicCityChangeBatchAttach = (DicCityChangeBatchAttach) record.toBean(DicCityChangeBatchAttach.class);
		dicCityChangeBatchAttachDomain.insert(dicCityChangeBatchAttach);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicCityChangeBatchAttach dicCityChangeBatchAttach = (DicCityChangeBatchAttach) record.toBean(DicCityChangeBatchAttach.class);
		dicCityChangeBatchAttachDomain.update(dicCityChangeBatchAttach);
	}
	
	// 删除
	public void delete() {
		String delId = (String) getParameter("delId");
		dicCityChangeBatchAttachDomain.delete(delId);
	}
	
	private static int maxFileSize = 10 * 1024 * 1024;
	/**
	 * 保存上传文件到数据库
	 */
	public void uploadSave(){
		Record uploadRd = (Record) getParameter("uploadRd");
		String fileMess = (String) getParameter("fileMess");
		DicCityChangeBatch dicCityChangeBatch = (DicCityChangeBatch) uploadRd.toBean(DicCityChangeBatch.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<DicCityChangeBatchAttach> list = new ArrayList<DicCityChangeBatchAttach>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > maxFileSize) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			//获取当前日期
			DicCityChangeBatchAttach dataBean = new DicCityChangeBatchAttach();
			dataBean.setAttachId(IdHelp.getUUID32());
			dataBean.setAttachName(uploadfile.getFileName());
			dataBean.setAttachContent(uploadfile);
			dataBean.setBatchId(dicCityChangeBatch.getBatchId());
			dataBean.setAttachPeopleCode(dicCityChangeBatch.getOrganCode());
			dataBean.setAttachPeopleName(dicCityChangeBatch.getOrganName());
			dataBean.setAttachTime(DateUtil.getTime());
			list.add(dataBean);
		}
		attachmentDao.batchInsert(list);
	}
	
}