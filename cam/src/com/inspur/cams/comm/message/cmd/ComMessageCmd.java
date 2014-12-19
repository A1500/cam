package com.inspur.cams.comm.message.cmd;

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
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.message.dao.IComMessageAttachmentDao;
import com.inspur.cams.comm.message.data.ComMessage;
import com.inspur.cams.comm.message.data.ComMessageAttachment;
import com.inspur.cams.comm.message.domain.IComMessageDomain;
import com.inspur.comm.util.IdHelp;


/**
 * 首页消息框cmd
 * @author 
 * @date 2014-02-14
 */
public class ComMessageCmd extends BaseAjaxCommand {

	private IComMessageDomain comMessageDomain = ScaComponentFactory
			.getService(IComMessageDomain.class, "comMessageDomain/comMessageDomain");
	private IComMessageAttachmentDao attachmentDao = (IComMessageAttachmentDao) DaoFactory
			.getDao("com.inspur.cams.comm.message.dao.jdbc.ComMessageAttachmentDao");
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		ComMessage comMessage = (ComMessage) record.toBean(ComMessage.class);
		comMessageDomain.insert(comMessage);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		ComMessage comMessage = (ComMessage) record.toBean(ComMessage.class);
		comMessageDomain.update(comMessage);
	}
	
	// 删除
	@Trans
	public void delete() {
		String messageId = (String) getParameter("messageId");
		comMessageDomain.delete(messageId);
		attachmentDao.deleteByMessageId(messageId);
	}
	private static int maxFileSize = 10 * 1024 * 1024;
	/**
	 * 保存上传文件到数据库
	 */
	public void uploadSave(){
		Record uploadRd = (Record) getParameter("uploadRd");
		String fileMess = (String) getParameter("fileMess");
		ComMessage comMessage = (ComMessage) uploadRd.toBean(ComMessage.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<ComMessageAttachment> list = new ArrayList<ComMessageAttachment>();
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
			ComMessageAttachment dataBean = new ComMessageAttachment();
			dataBean.setAttachmentId(IdHelp.getUUID32());
			dataBean.setFileName(uploadfile.getFileName());
			dataBean.setFileContent(uploadfile);
			dataBean.setMessageId(comMessage.getMessageId());
			list.add(dataBean);
		}
		attachmentDao.batchInsert(list);
	}
}